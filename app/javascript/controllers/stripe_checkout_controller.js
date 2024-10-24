import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["form", "cardElement", "cardErrors", "submitButton", "nameInput"]
  static values = {
    publishableKey: String,
    clientSecret: String
  }

  connect() {
    console.log("Stripe Checkout controller connected");

    if (typeof Stripe === 'undefined') {
      console.error("Stripe.js not loaded!");
      return;
    }

    this.initializeStripe();

    // Only initialize on Turbo load if the card hasn't been created yet
    document.addEventListener('turbo:load', () => {
      if (!this.card) {
        this.initializeStripe();
      }
    });
  }

  initializeStripe() {
    console.log("Initializing Stripe with key:", this.publishableKeyValue);

    try {
      this.stripe = Stripe(this.publishableKeyValue);

      if (!this.stripe) {
        throw new Error("Stripe initialization failed: Stripe object not created.");
      }

      const elements = this.stripe.elements();
      console.log("Stripe elements initialized");

      // Create a card element
      this.card = elements.create('card', {
        style: {
          base: {
            fontSize: '16px',
            color: '#32325d',
            '::placeholder': {
              color: '#aab7c4'
            }
          },
          invalid: {
            color: '#fa755a',
            iconColor: '#fa755a'
          }
        },
        hidePostalCode: true
      });

      console.log("Mounting Stripe card element");
      this.card.mount(this.cardElementTarget);
      console.log("Stripe card element mounted");

      // Handle real-time validation errors from the card element
      this.card.on('change', (event) => {
        if (event.error) {
          this.showError(event.error.message);
        } else {
          this.clearError();
        }
      });
    } catch (error) {
      console.error("Error initializing Stripe:", error);
      this.showError("Failed to initialize payment form. Please try again.");
    }
  }

  async submitForm(event) {
    event.preventDefault();

    console.log("Submit form method called");

    this.setLoading(true);
    this.clearError();

    const cardHolderName = this.nameInputTarget.value;
    console.log("Card holder name:", cardHolderName);

    try {
      const { paymentIntent, error } = await this.stripe.confirmCardPayment(this.clientSecretValue, {
        payment_method: {
          card: this.card,
          billing_details: { name: cardHolderName }
        }
      });

      if (error) {
        this.handlePaymentError(error);
      } else if (paymentIntent.status === 'succeeded') {
        console.log("Payment succeeded, handling on server");
        await this.handleServerConfirmation(paymentIntent.id);
      } else {
        console.warn("Unexpected payment intent status:", paymentIntent.status);
        this.showError(`Unexpected payment status: ${paymentIntent.status}. Please try again.`);
      }
    } catch (e) {
      console.error("An error occurred:", e);
      this.showError("An unexpected error occurred. Please try again.");
    } finally {
      this.setLoading(false);
    }
  }

  handlePaymentError(error) {
    console.error("Payment error:", error);

    if (error.type === 'invalid_request_error' && error.code === 'payment_intent_unexpected_state') {
      this.showError("There was an issue processing your payment. Please try again or contact support.");
    } else {
      this.showError(error.message);
    }
  }

  async handleServerConfirmation(paymentIntentId) {
    try {
      const response = await fetch('/checkouts', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json', 'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content },
        body: JSON.stringify({ payment_intent_id: paymentIntentId })
      });

      const result = await response.json();

      if (result.success) {
        console.log("Order created successfully");
        window.location.href = `/orders/${result.order_id}`;
      } else {
        console.error("Order creation failed:", result.error);
        this.showError(`Error: ${result.error}. Please contact support.`);
      }
    } catch (e) {
      console.error("Server confirmation error:", e);
      this.showError("An error occurred while processing your order. Please contact support.");
    }
  }

  showError(message) {
    this.cardErrorsTarget.textContent = message;
    this.cardErrorsTarget.style.display = 'block';
  }

  clearError() {
    this.cardErrorsTarget.textContent = '';
    this.cardErrorsTarget.style.display = 'none';
  }

  setLoading(isLoading) {
    this.submitButtonTarget.disabled = isLoading;
    this.submitButtonTarget.textContent = isLoading ? 'Processing...' : 'Pay';
  }
}

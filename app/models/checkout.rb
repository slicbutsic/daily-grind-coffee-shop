class Checkout
  include ActiveModel::Model

  attr_accessor :cart, :payment_intent_id, :shipping_cost

  def create_payment_intent
    return false if cart.cart_items.empty?

    amount = ((total_with_shipping) * 100).to_i

    payment_intent = Stripe::PaymentIntent.create(
      amount: amount,
      currency: 'usd',
      automatic_payment_methods: { enabled: true }
    )

    payment_intent.client_secret
  end

  def process_payment
    return false if payment_intent_id.blank?

    payment_intent = Stripe::PaymentIntent.retrieve(payment_intent_id)

    Rails.logger.info "Payment Intent Status: #{payment_intent.status}"

    payment_intent.status == 'succeeded'
  end

  def create_order(user)
    return nil if cart.cart_items.empty?

    Order.transaction do
      order = Order.create!(
        user: user,
        total: total_with_shipping,
        status: 'paid'
      )

      cart.cart_items.each do |cart_item|
        order.order_items.create!(
          product: cart_item.product,
          quantity: cart_item.quantity,
          price: cart_item.product.price
        )
      end

      order
    end
  end

  private

  def total_with_shipping
    cart.total_price + (shipping_cost || 0)
  end
end

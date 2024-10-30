import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["form"];

  connect() {
    console.log("Mobile Search controller connected");
    document.addEventListener('click', this.handleOutsideClick.bind(this));
    window.addEventListener('resize', this.hideForm.bind(this)); // Add resize event listener
  }

  disconnect() {
    document.removeEventListener('click', this.handleOutsideClick.bind(this));
    window.removeEventListener('resize', this.hideForm.bind(this)); // Remove resize event listener
  }

  toggleForm(event) {
    event.stopPropagation(); // Prevent click from bubbling up
    this.formTarget.classList.toggle("hidden"); // Toggle the hidden class

    // If the form is shown, focus on the input field
    if (!this.formTarget.classList.contains("hidden")) {
      const input = this.formTarget.querySelector('input');
      if (input) {
        input.focus(); // Focus on the input field when shown
      }
    }
  }

  handleOutsideClick(event) {
    if (!this.element.contains(event.target) && !this.formTarget.classList.contains("hidden")) {
      this.hideForm(); // Hide the form if clicking outside
    }
  }

  hideForm() {
    this.formTarget.classList.add("hidden"); // Hide the form
  }
}

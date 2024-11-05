import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["form"];

  connect() {
    console.log("Mobile Search controller connected");
    document.addEventListener('click', this.handleOutsideClick.bind(this));
    window.addEventListener('resize', this.hideForm.bind(this));
  }

  disconnect() {
    document.removeEventListener('click', this.handleOutsideClick.bind(this));
    window.removeEventListener('resize', this.hideForm.bind(this)); 
  }

  toggleForm(event) {
    event.stopPropagation();
    this.formTarget.classList.toggle("hidden");


    if (!this.formTarget.classList.contains("hidden")) {
      const input = this.formTarget.querySelector('input');
      if (input) {
        input.focus();
      }
    }
  }

  handleOutsideClick(event) {
    if (!this.element.contains(event.target) && !this.formTarget.classList.contains("hidden")) {
      this.hideForm();
    }
  }

  hideForm() {
    this.formTarget.classList.add("hidden");
  }

}

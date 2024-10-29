// app/javascript/controllers/category_dropdown_controller.js
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["menu"];

  connect() {
    this.isOpen = false;
    document.addEventListener("click", this.handleClickOutside.bind(this));
  }

  disconnect() {
    document.removeEventListener("click", this.handleClickOutside.bind(this));
  }

  toggle() {
    this.isOpen = !this.isOpen;
    this.menuTarget.style.display = this.isOpen ? "block" : "none";
  }

  hide() {
    this.isOpen = false;
    this.menuTarget.style.display = "none";
  }

  handleClickOutside(event) {
    if (!this.element.contains(event.target) && this.isOpen) {
      this.hide();
    }
  }
}

// app/javascript/controllers/navbar_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["categories"]

  connect() {
  }

  showCategories() {
    this.categoriesTarget.style.display = 'block'
    setTimeout(() => {
      this.categoriesTarget.style.maxHeight = '200px'
    }, 10)
  }

  hideCategories() {
    this.categoriesTarget.style.maxHeight = '0'
    setTimeout(() => {
      this.categoriesTarget.style.display = 'none'
    }, 600)
  }
}

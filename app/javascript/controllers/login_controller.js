import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "modal", "wrapper" ]

  connect() {
    console.log("Login controller connected")
  }

  showModal(event) {
    event.preventDefault()
    console.log("Show modal called")
    this.modalTarget.classList.remove('hidden')
  }

  hideModal(event) {
    if (!this.wrapperTarget.contains(event.target)) {
      this.modalTarget.classList.add('hidden')
    }
  }

  toggleModal(event) {
    event.stopPropagation()
    this.modalTarget.classList.toggle('hidden')
  }
}

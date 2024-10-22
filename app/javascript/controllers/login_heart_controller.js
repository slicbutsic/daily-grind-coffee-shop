import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "modal" ]

  showModal(event) {
    event.preventDefault()
    this.modalTarget.classList.remove('hidden')
  }

  hideModal() {
    this.modalTarget.classList.add('hidden')
  }
}

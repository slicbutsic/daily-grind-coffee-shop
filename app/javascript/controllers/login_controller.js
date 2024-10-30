import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "modal" ]

  connect() {
    console.log("Login controller connected")
    // Add resize event listener to window
    window.addEventListener('resize', this.resizeHandler.bind(this))
    // Add click event listener to document
    document.addEventListener('click', this.outsideClickHandler.bind(this))
  }

  disconnect() {
    // Remove the event listeners when the controller is disconnected
    window.removeEventListener('resize', this.resizeHandler.bind(this))
    document.removeEventListener('click', this.outsideClickHandler.bind(this))
  }

  showModal(event) {
    event.preventDefault()
    console.log("Show modal called")
    this.modalTarget.classList.remove('hidden')
  }

  hideModal() {
    this.modalTarget.classList.add('hidden')
  }

  toggleModal(event) {
    event.stopPropagation()
    this.modalTarget.classList.toggle('hidden')
  }

  resizeHandler() {
    // Close the modal when the window is resized
    if (!this.modalTarget.classList.contains('hidden')) {
      this.hideModal()
    }
  }

  outsideClickHandler(event) {
    // Close the modal when clicking outside of it
    if (!this.element.contains(event.target) && !this.modalTarget.classList.contains('hidden')) {
      this.hideModal()
    }
  }
}

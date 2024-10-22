import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["icon"]
  static values = { url: String }

  toggle(event) {
    event.preventDefault()

    fetch(this.urlValue, {
      method: "POST",
      headers: {
        "X-CSRF-Token": document.querySelector("[name='csrf-token']").content,
        "Accept": "application/json",
        "Content-Type": "application/json"
      },
      credentials: "same-origin"
    })
    .then(response => response.json())
    .then(data => {
      if (data.added) {
        this.iconTarget.classList.remove("far")
        this.iconTarget.classList.add("fas")
      } else {
        this.iconTarget.classList.remove("fas")
        this.iconTarget.classList.add("far")
      }
    })
    .catch(error => console.error('Error:', error))
  }
}

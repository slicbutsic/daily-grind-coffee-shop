import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["form", "input"]

  submit() {
    clearTimeout(this.timeout)
    this.timeout = setTimeout(() => {
      const query = this.inputTarget.value
      const url = new URL(this.formTarget.action)
      url.searchParams.set('query', query)

      // Remember cursor position
      const cursorPosition = this.inputTarget.selectionStart

      fetch(url, {
        headers: {
          'Accept': 'text/html'
        }
      })
        .then(response => response.text())
        .then(html => {
          const parser = new DOMParser()
          const doc = parser.parseFromString(html, 'text/html')
          const newProductList = doc.getElementById('product-list')

          // Update only the product list
          document.getElementById('product-list').innerHTML = newProductList.innerHTML

          // Restore focus and cursor position
          this.inputTarget.focus()
          this.inputTarget.setSelectionRange(cursorPosition, cursorPosition)
        })
    }, 300) // Debounce time
  }
}

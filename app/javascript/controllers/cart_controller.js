import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["sideCart", "cartContent"]

  connect() {
    this.updateCartCount()
  }

  open() {
    this.sideCartTarget.classList.remove('translate-x-full')
    this.updateCartContent()
  }

  close() {
    this.sideCartTarget.classList.add('translate-x-full')
    this.updateCartCountFromContent()
    this.updateAllCartIcons()
  }

  updateCount(event) {
    event.preventDefault()
    const form = event.target.closest('form')
    const formData = new FormData(form)

    fetch(form.action, {
      method: form.method,
      body: formData,
      headers: {
        'X-Requested-With': 'XMLHttpRequest',
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
      },
      credentials: 'same-origin'
    })
    .then(response => response.json())
    .then(data => {
      this.updateCartCountDisplay(data.cart_count)
      this.updateCartIcon(event.target, data.in_cart)
    })
    .catch(error => console.error('Error:', error))
  }

  updateCartContent() {
    fetch('/cart', {
      headers: {
        'Accept': 'text/html',
        'X-Requested-With': 'XMLHttpRequest'
      }
    })
    .then(response => response.text())
    .then(html => {
      this.cartContentTarget.innerHTML = html
    })
    .catch(error => {
      console.error('Error updating cart:', error)
      this.cartContentTarget.innerHTML = '<p class="text-center p-4">Error loading cart</p>'
    })
  }

  updateCartCountFromContent() {
    const quantityElements = this.cartContentTarget.querySelectorAll('.bg-slate-100')
    let totalItems = 0
    quantityElements.forEach(el => {
      totalItems += parseInt(el.textContent, 10)
    })
    this.updateCartCountDisplay(totalItems)
    return totalItems
  }

  updateCartCountDisplay(count) {
    const cartCountElement = document.getElementById('cart-count')
    if (cartCountElement) {
      if (count > 0) {
        cartCountElement.textContent = count
        cartCountElement.classList.remove('hidden')
      } else {
        cartCountElement.textContent = ''
        cartCountElement.classList.add('hidden')
      }
    }
  }

  updateCartIcon(button, inCart) {
    const icon = button.querySelector('i')
    if (inCart) {
      icon.classList.remove('text-gray-400')
      icon.classList.add('text-black')
    } else {
      icon.classList.remove('text-black')
      icon.classList.add('text-gray-400')
    }
  }

  updateAllCartIcons() {
    const totalItems = this.updateCartCountFromContent()
    document.querySelectorAll('.cart-icon').forEach(icon => {
      if (totalItems === 0) {
        icon.classList.remove('text-black')
        icon.classList.add('text-gray-400')
      }
    })
  }
}

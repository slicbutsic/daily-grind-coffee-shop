import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["dropdown", "icon"]

  connect() {
    console.log("MobileCartController connected")
    document.addEventListener('click', this.handleOutsideClick.bind(this))
    window.addEventListener('resize', this.closeDropdown.bind(this))
    this.updateCartIconColor()
  }

  disconnect() {
    document.removeEventListener('click', this.handleOutsideClick.bind(this))
    window.removeEventListener('resize', this.closeDropdown.bind(this))
  }

  async toggleDropdown(event) {
    event.stopPropagation() // Prevent the click from immediately triggering the outside click handler
    event.preventDefault()

    if (this.hasDropdownTarget) {
      console.log("Dropdown toggled")
      this.dropdownTarget.classList.toggle("hidden")

      if (!this.dropdownTarget.classList.contains("hidden")) {
        await this.loadCartContents()
      }
    } else {
      console.error("Dropdown target not found")
    }
  }

  closeDropdown() {
    if (this.hasDropdownTarget) {
      console.log("Dropdown closed")
      this.dropdownTarget.classList.add("hidden")
    }
  }

  async loadCartContents() {
    try {
      const response = await fetch('/cart', {
        headers: {
          'Accept': 'text/html',
          'X-Requested-With': 'XMLHttpRequest'
        }
      })

      if (response.ok) {
        const html = await response.text()
        this.dropdownTarget.innerHTML = html
        this.updateCartIconColor()
      } else {
        console.error('Failed to load cart contents')
      }
    } catch (error) {
      console.error("Error loading cart contents:", error)
    }
  }

  updateCartIconColor(isEmpty = null) {
    const iconLink = this.iconTarget.querySelector('a')
    if (isEmpty === null) {
      isEmpty = this.dropdownTarget.querySelectorAll('.border-b').length === 0
    }
    if (isEmpty) {
      iconLink.classList.remove('bg-[#257A57]')
    } else {
      iconLink.classList.add('bg-[#257A57]')
    }
  }

  async updateCartIcon(event) {
    event.stopPropagation() // Prevent the click from immediately triggering the outside click handler
    const form = event.target.closest('form')
    const formData = new FormData(form)

    try {
      const response = await fetch(form.action, {
        method: form.method,
        body: formData,
        headers: {
          'X-Requested-With': 'XMLHttpRequest',
          'Accept': 'application/json'
        },
        credentials: 'same-origin'
      })

      if (response.ok) {
        const data = await response.json()
        this.dropdownTarget.innerHTML = data.cart_html
        this.updateCartIconColor(data.cart_empty)
      } else {
        console.error('Failed to update cart')
      }
    } catch (error) {
      console.error('Error updating cart:', error)
    }
  }

  handleOutsideClick(event) {
    // Check if the click is outside the dropdown and the icon
    if (!this.element.contains(event.target) && !this.dropdownTarget.classList.contains("hidden")) {
      this.closeDropdown()
    }
  }
}

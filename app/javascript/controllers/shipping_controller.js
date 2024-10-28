import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "shippingOptions", "stateSelect", "totalPrice", "cartData" ]

  connect() {
    this.updateTotal()
  }

  calculateShipping() {
    const state = this.stateSelectTarget.value
    fetch(`/calculate_shipping?state=${state}`)
      .then(response => response.text())
      .then(html => {
        this.shippingOptionsTarget.innerHTML = html
        this.updateTotal()
      })
  }

  updateTotal() {
    const selectedShipping = this.shippingOptionsTarget.querySelector('input[name="shipping_option"]:checked')
    const cartTotal = parseFloat(this.cartDataTarget.dataset.cartTotal)
    const normalShippingCost = parseFloat(this.cartDataTarget.dataset.normalShippingCost)
    const fastShippingCost = parseFloat(this.cartDataTarget.dataset.fastShippingCost)

    const shippingCost = selectedShipping.value === 'fast' ? fastShippingCost : normalShippingCost
    const newTotal = (cartTotal + shippingCost).toFixed(2)

    this.totalPriceTarget.textContent = `$${newTotal}`
  }
}

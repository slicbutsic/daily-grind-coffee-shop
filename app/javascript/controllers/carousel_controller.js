import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["slide"]

  connect() {
    this.currentIndex = 0
    this.showCurrentSlide()
    this.startAutoSlide()
  }

  disconnect() {
    this.stopAutoSlide()
  }

  next() {
    this.currentIndex = (this.currentIndex + 1) % this.slideTargets.length
    this.showCurrentSlide()
  }

  previous() {
    this.currentIndex = (this.currentIndex - 1 + this.slideTargets.length) % this.slideTargets.length
    this.showCurrentSlide()
  }

  showCurrentSlide() {
    this.slideTargets.forEach((slide, index) => {
      slide.classList.toggle("hidden", index !== this.currentIndex)
    })
  }

  startAutoSlide() {
    this.autoSlideInterval = setInterval(() => {
      this.next()
    }, 5000) // 5000 milliseconds = 5 seconds
  }

  stopAutoSlide() {
    if (this.autoSlideInterval) {
      clearInterval(this.autoSlideInterval)
    }
  }

  // Optional: pause auto-slide on hover
  mouseEnter() {
    this.stopAutoSlide()
  }

  mouseLeave() {
    this.startAutoSlide()
  }
}

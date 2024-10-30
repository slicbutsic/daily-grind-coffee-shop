import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    console.log("HamburgerController connected");
  }

  toggleSideBar() {
    console.log("Toggling sidebar...");
    const menu = document.getElementById('mobile-menu');
    const hamburgerIcon = document.getElementById('hamburger-icon');
    const closeIcon = document.getElementById('close-icon');

    if (menu) {
      // Check if the menu is currently hidden or shown
      const isHidden = menu.classList.contains('-translate-x-full');
      if (isHidden) {
        menu.classList.remove('-translate-x-full'); // Show the menu
        menu.setAttribute('aria-hidden', 'false'); // Update accessibility attribute
        hamburgerIcon.classList.add('hidden'); // Hide hamburger icon
        closeIcon.classList.remove('hidden'); // Show close icon
      } else {
        menu.classList.add('-translate-x-full'); // Hide the menu
        menu.setAttribute('aria-hidden', 'true'); // Update accessibility attribute
        hamburgerIcon.classList.remove('hidden'); // Show hamburger icon
        closeIcon.classList.add('hidden'); // Hide close icon
      }
      console.log(menu.classList); // Log current classes for debugging
    } else {
      console.error("Mobile menu not found.");
    }
  }

  closeMenu() {
    console.log("Closing sidebar...");
    const menu = document.getElementById('mobile-menu');
    const hamburgerIcon = document.getElementById('hamburger-icon');
    const closeIcon = document.getElementById('close-icon');

    if (menu) {
      menu.classList.add('-translate-x-full'); // Hide the menu
      menu.setAttribute('aria-hidden', 'true'); // Update accessibility attribute
      hamburgerIcon.classList.remove('hidden'); // Show hamburger icon
      closeIcon.classList.add('hidden'); // Hide close icon
      console.log(menu.classList); // Log current classes for debugging
    } else {
      console.error("Mobile menu not found.");
    }
  }
}


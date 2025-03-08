import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="dialog"
export default class extends Controller {
  connect() {
    this.open();
  }

  clickOutside(event) {
    if (event.target === this.element) this.element.close();
  }

  submitEnd(event) {
    if (event.detail.success) {
      this.close();
    }
  }

  open() {
    this.element.showModal();
    document.body.classList.add('overflow-hidden');
  }

  close() {
    this.element.close();
    const frame = document.getElementById('new_influencer');
    frame.removeAttribute("src");
    frame.innerHTML = "";
  }

}

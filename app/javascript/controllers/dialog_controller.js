import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="dialog"
export default class extends Controller {
  connect() {
    this.open();
    this.element.addEventListener("close", this.enableBodyScroll.bind(this));
  }

  disconnect() {
    this.element.removeEventListener("close", this.enableBodyScroll.bind(this));
  }

  enableBodyScroll() {
    document.body.classList.remove('overflow-hidden');
  }

  clickOutside(event) {
    if (event.target === this.element) this.element.close();
  }

  submitEnd(event) {
    if (event.detail.success) this.close();
  }

  open() {
    this.element.showModal();
    document.body.classList.add('overflow-hidden');
  }

  close() {
    this.element.close();
  }
}

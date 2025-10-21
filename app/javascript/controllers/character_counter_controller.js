import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="character-counter"
export default class extends Controller {
  static targets = ['input', 'counter'];
  static values = { max: Number };
  connect() {
    this.update();
  }

  update() {
    const length = this.inputTarget.value.length;
    const remaining = this.hasMaxValue ? this.maxValue - length : null;

    if(this.hasMaxValue) {
      this.counterTarget.textContent = `${length} / ${this.maxValue} characters`;

      if(remaining < 50) {
        this.counterTarget.classList.add('text-red-600');
        this.counterTarget.classList.remove('text-gray-600', 'text-yellow-600');
      } else if (remaining < 100) {
        this.counterTarget.classList.add("text-yellow-600")
        this.counterTarget.classList.remove("text-gray-600", "text-red-600")
      } else {
        this.counterTarget.classList.add("text-gray-600")
        this.counterTarget.classList.remove("text-red-600", "text-yellow-600")
      }
    } else {
      this.counterTarget.textContent = `${length} characters`;
    }
  }
}

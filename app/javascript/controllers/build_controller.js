import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="build"
export default class extends Controller {
  static targets = ["input", "button"]
  connect() {
  }

  validate() {
    // if (this.checkInputs()) {
    //   this.buttonTarget.classList.remove('disabled')
    // } else {
    //   this.buttonTarget.classList.add('disabled')
    // }
  }

  checkInputs() {
    const allFilled = this.inputTargets.every(input => input.value !== "");
    return allFilled
  }
}

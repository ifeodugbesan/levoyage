import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="guesses"
export default class extends Controller {
  static targets = ["form", "checkbox", "deselect", "submit", "label", "hiddenSubmit"]

  connect() {
    console.log("yoooooooo")
  }

  checkGuess(event) {
    const checkboxes = this.checkboxTargets.filter(checkbox => checkbox.checked);
    const unchecked = this.checkboxTargets.filter(checkbox => !checkbox.checked);

    checkboxes.length > 0 ? this.deselectTarget.classList.remove("disabled") : this.deselectTarget.classList.add("disabled")

    if (checkboxes.length > 3) {
      this.submitTarget.classList.remove("disabled")
      unchecked.forEach((checkbox) => {
        checkbox.nextElementSibling.classList.add('pe-none');
      })
    } else {
      this.submitTarget.classList.add("disabled")
      unchecked.forEach((checkbox) => {
        checkbox.nextElementSibling.classList.remove('pe-none');
      })
    }
  }

  deselect() {
    const unchecked = this.checkboxTargets.filter(checkbox => !checkbox.checked);
    unchecked.forEach((checkbox) => {
      checkbox.nextElementSibling.classList.remove('pe-none');
    })
    this.checkboxTargets.forEach((checkbox) => {
      checkbox.checked = false
    });
    this.deselectTarget.classList.add("disabled")
    this.submitTarget.classList.add("disabled")
  }

  submitGuess(event) {
    event.preventDefault()

    console.log("hiiiiiiiiya")

    fetch(this.formTarget.action, {
      method: "POST", // Could be dynamic with Stimulus values
      headers: { "Accept": "application/json" },
      body: new FormData(this.formTarget)
    })
      .then(response => response.json())
      .then((data) => {
        console.log(data)
      })


    // console.log("Guess submitted!!!")
    // const allCheckboxes = this.checkboxTargets
    // const checkboxes = this.checkboxTargets.filter(checkbox => checkbox.checked);
    // checkboxes.forEach((checkbox, index) => {
    //   index++
    //   setTimeout(() => {
    //     checkbox.nextElementSibling.classList.add('bounce');
    //   }, index * 100);
    //   setTimeout(() => {
    //     checkbox.nextElementSibling.classList.remove('bounce');
    //   }, index * 500);
    //   setTimeout(() => {
    //     checkbox.nextElementSibling.classList.add('move-to-top');
    //     checkbox.nextElementSibling.style.transform = "translateY(0%)";
    //   }, 1100);
    //       setTimeout(() => {
    //   this.hiddenSubmitTarget.click();
    // }, 1200);
    // })
    // allCheckboxes.forEach((checkbox) => {
    //   setTimeout(() => {
    //     checkbox.nextElementSibling.classList.add('fade-in');
    //   }, 1000);
    //   setTimeout(() => {
    //     checkbox.nextElementSibling.classList.remove('fade-in');
    //   }, 1300);
    // })

  }
}

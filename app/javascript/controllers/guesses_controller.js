import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="guesses"
export default class extends Controller {
  static targets = ["form", "checkbox", "deselect", "label", "submit", "gridContainer", "grid", "popup",
                    "mistake", "mistakesContainer", "buttons", "formContainer", "resultsContainer", "container"]

  connect() {
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

  showResults() {
    this.resultsContainerTarget.classList.remove('d-none');
    setTimeout(() => {
      this.resultsContainerTarget.style.opacity = 1
    }, 100);
  }

  close() {
    this.resultsContainerTarget.style.opacity = 0
    setTimeout(() => {
      this.resultsContainerTarget.classList.add('d-none')
    }, 1000);
  }

  submitGuess(event) {
    event.preventDefault()

    this.submitTarget.classList.add('disabled')
    setTimeout(() => {
    }, 1000);

    fetch(this.formTarget.action, {
      method: "POST", // Could be dynamic with Stimulus values
      headers: { "Accept": "application/json" },
      body: new FormData(this.formTarget)
    })
      .then(response => response.json())
      .then((data) => {

        if (data.already_guessed) {
          const message = `<span class="popup" data-guesses-target="popup shake-horizontally">Already guessed!</span>`
          this.gridContainerTarget.insertAdjacentHTML("beforeend", message)
          setTimeout(() => {
            this.popupTarget.remove()
          }, 3000);
          return
        }

        const allCheckboxes = this.checkboxTargets
        const checkboxes = this.checkboxTargets.filter(checkbox => checkbox.checked);
        checkboxes.forEach((checkbox, index) => {
          index++

          // ADD BOUNCE EFFECT ON SELECTED TILES
          setTimeout(() => {
            checkbox.nextElementSibling.classList.add('bounce');
          }, index * 100);

          // REMOVE BOUNCE EFFECT ON SELECTED TILES
          setTimeout(() => {
            checkbox.nextElementSibling.classList.remove('bounce');
          }, index * 500);

          // WRONG GUESS HORIZONTAL SHAKE AND REMOVING A MISTAKE BALL
          if (data.wrong) {
            setTimeout(() => {
              checkbox.nextElementSibling.classList.add('wrong-guess');
            }, 1100);
            
            setTimeout(() => {
              checkbox.nextElementSibling.classList.remove('wrong-guess');
            }, 3100);

            const mistake = this.mistakeTargets.slice(-1)[0]

            setTimeout(() => {
              mistake.classList.add('one-mistake');
            }, 1100);
            setTimeout(() => {
              mistake.remove();
            }, 1900);
          }
            
          // MOVING SELECTED TILES TO THE TOP IF CORRECT
          if (data.success) {
            setTimeout(() => {
              checkbox.nextElementSibling.classList.add('move-to-top');
              checkbox.nextElementSibling.style.transform = "translateY(0%)";
            }, 1100);
          }

        })

        // HIDING BUTTONS WHEN THE GAME ENDS AND INSERTING RESULTS
        if (data.failed || data.complete) {
          setTimeout(() => {
            this.buttonsTarget.classList.add('hide-section');
            this.mistakesContainerTarget.classList.add('hide-section');
          }, 1100);
          setTimeout(() => {
            const buttons = `
              <div class="d-flex align-items-center justify-content-center mt-3 back-to-connections">
                <p class="secondary-button con-btn me-3 mb-0" data-action="click->guesses#showResults" data-guesses-target="deselect">VIEW RESULTS</p>
                <a class="btn secondary-button" href="/connections">GO BACK TO CONNECTIONS</a>
              </div>
            `
            this.formContainerTarget.insertAdjacentHTML("beforeend", buttons)
            this.buttonsTarget.classList.add('d-none');
            this.mistakesContainerTarget.classList.add('d-none');
          }, 2100);
          setTimeout(() => {
            this.containerTarget.insertAdjacentHTML("afterbegin", data.inserted_results)
          }, 2100);
        }

        // INSERTING COMPLETED GROUP
        if (data.group) {
          const group = `
            <div class="formed-group ${data.group.level} inserted-group">
              <h5>${data.group.title}</h5>
              <p class="mb-0">${data.group.words}</p>
            </div>
          `
          setTimeout(() => {
            this.gridTarget.insertAdjacentHTML("afterbegin", group)
          }, 1200);

          setTimeout(() => {
            this.formContainerTarget.innerHTML = data.inserted_item
          }, 1600);
        }

        // PLAYER HAS COMPLETED CONNECTIONS
        if (data.complete) {
          const message = `<span class="popup" data-guesses-target="popup">Great!</span>`
          setTimeout(() => {
            this.gridContainerTarget.insertAdjacentHTML("beforeend", message)
          }, 1000);
          setTimeout(() => {
            this.popupTarget.remove()
          }, 6000);
        }

        // PLAYER HAS FAILED CONNECTIONS
        if (data.failed) {
          const message = `<span class="popup" data-guesses-target="popup">Unlucky!</span>`
          setTimeout(() => {
            this.gridContainerTarget.insertAdjacentHTML("beforeend", message)
          }, 1000);
          setTimeout(() => {
            this.popupTarget.remove()
          }, 6000);

          // FADE OUT UNSOLVED GROUPS
          setTimeout(() => {
            this.gridTarget.style.opacity = 0;
          }, 1800);
          setTimeout(() => {
            this.gridTarget.remove()
          }, 2100);
          setTimeout(() => {
            this.gridContainerTarget.insertAdjacentHTML("beforeend", data.inserted_unsolved)
          }, 2100);
        }

        // INSERTING AND REMOVING MESSAGE
        if (data.message) {
          const message = `<span class="popup" data-guesses-target="popup shake-horizontally">${data.message}</span>`
          setTimeout(() => {
            this.gridContainerTarget.insertAdjacentHTML("beforeend", message)
          }, 1000);
          setTimeout(() => {
            this.popupTarget.remove()
          }, 3000);
        }

      })

  }
}

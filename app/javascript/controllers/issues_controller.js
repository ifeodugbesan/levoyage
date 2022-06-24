import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["tags", "tagsBtn", "form"]
  connect() {
    // console.log('hello world')
    // if (this.hasTagsTarget) {
    //   if (window.innerWidth <= 576) {
    //     this.tagsTarget.classList.remove('show')
    //     this.tagsBtnTarget.classList.add('collapsed')
    //   }
    // }
  }

  showForm() {
    this.formTarget.classList.toggle('d-none');
  }
}

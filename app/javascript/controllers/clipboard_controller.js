import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="clipboard"
export default class extends Controller {
  static targets = ["source", "feedback"];

  copy() {
    navigator.clipboard.writeText(this.sourceTarget.value)
      .then(() => {
        this.feedbackTarget.style.display = "inline";
        setTimeout(() => {
          this.feedbackTarget.style.display = "none";
        }, 2000);
      })
      .catch(error => console.log(error));
  }
}







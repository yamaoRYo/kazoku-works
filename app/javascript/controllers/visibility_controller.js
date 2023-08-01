import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="visibility"
export default class extends Controller {
  static targets = ["select", "checkboxes"]

  connect() {
    this.updateCheckboxes()
  }

  updateCheckboxes() {
    if (this.selectTarget.value == "partial") {
      this.checkboxesTarget.style.display = "block";
    } else {
      this.checkboxesTarget.style.display = "none";
      }
    }
}

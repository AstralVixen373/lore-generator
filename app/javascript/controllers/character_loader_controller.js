import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["overlay", "submit"]

  show() {
    this.overlayTarget.classList.remove("d-none")
    this.overlayTarget.classList.add("d-flex")

    if (this.hasSubmitTarget) {
      this.submitTarget.disabled = true
      this.submitTarget.value = "Invocation en cours..."
    }
  }
}

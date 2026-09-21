// app/javascript/controllers/dismiss_controller.js
// Ersetzt @stimulus-components/removable aus dem Buch.
// Wird von Rails automatisch als "dismiss" registriert (eagerLoadControllersFrom).
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { after: { type: Number, default: 5000 } }   // 0 = nie automatisch

  connect() {
    if (this.afterValue > 0) {
      this.timeout = setTimeout(() => this.close(), this.afterValue)
    }
  }

  disconnect() {
    clearTimeout(this.timeout)
  }

  close() {
    clearTimeout(this.timeout)
    this.element.classList.add("is-leaving")
    this.element.addEventListener("animationend", () => this.element.remove(), { once: true })
  }
}

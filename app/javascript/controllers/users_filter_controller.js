import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="users-filter"
export default class extends Controller {
  static targets = ["input", "row"]

  filter() {
    if (!this.hasInputTarget) return

    const query = this.inputTarget.value.toLowerCase().trim()

    this.rowTargets.forEach((row) => {
      const text = row.textContent.toLowerCase()
      row.classList.toggle("hidden", !text.includes(query))
    })
  }

  navigate(event) {
    if (event.target.closest("a") || event.target.closest("button")) return
    
    const url = event.currentTarget.dataset.url
    if (url) {
      Turbo.visit(url)
    }
  }
}

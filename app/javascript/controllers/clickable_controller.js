import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="clickable"
export default class extends Controller {
  navigate(event) {
    // Don't navigate if clicking a link or button inside the row
    if (event.target.closest("a") || event.target.closest("button")) return
    
    const url = event.currentTarget.dataset.url
    if (url) {
      Turbo.visit(url)
    }
  }
}

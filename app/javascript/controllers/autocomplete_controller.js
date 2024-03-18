// app/javascript/controllers/autocomplete_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "results"]
  static values = { url: String }

  connect() {
    this.inputTarget.addEventListener('keyup', event => {
      this.search()
    })
  }

  search() {
    const query = this.inputTarget.value.trim()
    if (query.length === 0) {
      this.resultsTarget.innerHTML = ''
      return
    }

    const url = `${this.urlValue}?query=${encodeURIComponent(query)}`
    fetch(url)
      .then(response => response.json())
      .then(data => this.displayResults(data))
      .catch(error => console.error("Error fetching autocomplete results:", error))
  }

  displayResults(data) {
    this.clearResults()
    data.forEach(item => {
      const element = document.createElement("li")
      element.textContent = item.name
      element.className = 'autocomplete-result'
      element.tabIndex = 0
      element.addEventListener('click', () => {
        this.inputTarget.value = item.name
        this.clearResults()
      })
      this.resultsTarget.appendChild(element)
    })
  }

  clearResults() {
    this.resultsTarget.innerHTML = ''
  }
}

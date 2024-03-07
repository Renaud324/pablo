import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search-bar"
export default class extends Controller {
  static targets = ["form", "input", "list"]

  connect() {
    console.log(
      "connected to the search-bar controller"
    );
  }

  search(event) {
    // Prevent fetching when the input is empty
    if (this.inputTarget.value.trim() === "") {
      this.listTarget.innerHTML = ""; // Clear previous results or set to default state
      return;
    }

    const url = `${this.formTarget.action}?query=${encodeURIComponent(this.inputTarget.value)}`;
    fetch(url, {headers: {"Accept": "text/plain"}})
      .then(response => response.text())
      .then((data) => {
        this.listTarget.outerHTML = data;
      });
  }

}

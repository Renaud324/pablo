import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["form", "input", "list", "tasks"]

  connect() {
  }

  search(event) {

    const url = `${this.formTarget.action}?query=${encodeURIComponent(this.inputTarget.value)}`;
    fetch(url, { headers: { "Accept": "application/json" } })
      .then(response => response.json())
      .then((data) => {
        console.log(data.list_html)
        this.tasksTarget.outerHTML = data.tasks_html;
        this.listTarget.outerHTML = data.list_html;
      });
  }
}


import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search-bar"
export default class extends Controller {

  static targets = ["query"]

  connect() {
    console.log ("i am connected to the search controller")
  }

  clearQuery(event) {
    if (this.queryTarget.value.trim() === "") {
      event.preventDefault();
      this.element.action = "/";
      this.element.submit();
    }
  }

}

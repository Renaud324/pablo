import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="sidebar-deploy"
export default class extends Controller {

  connect() {
    console.log("Hello from the other siiiiide");
  }

  toggleMenu() {
    this.element.classList.toggle("close");
  }
}

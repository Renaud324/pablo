import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="sidebar-deploy"
export default class extends Controller {

  connect() {
    console.log("Hello from the other siiiiide");
  }

  toggleMenu() {
    this.element.classList.toggle("close");
    this.adjustMainContent(); 
  }

  adjustMainContent() {
    const mainContent = document.querySelector('.main-content');
    mainContent.classList.toggle("collapsed");
  }
}

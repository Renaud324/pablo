import { Application } from "@hotwired/stimulus"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }

document.addEventListener("DOMContentLoaded", function() {
  const openModalButton = document.getElementById("openNewTaskModal");
  if (openModalButton) {
    openModalButton.addEventListener("click", function(event) {
      event.preventDefault();
      const modal = document.getElementById("newTaskModal");
      if (modal) {
        modal.style.display = "block";
      } else {
        console.error("Modal element not found.");
      }
    });
  }
});

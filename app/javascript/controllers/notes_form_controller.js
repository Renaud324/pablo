import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="notes-form"
export default class extends Controller {
  static targets = ["togglableElement"]

  connect() {
    console.log("suis dans notes JS controller");
  }

  fire() {
    this.togglableElementTarget.classList.toggle("d-none");
  }

  submit(event) {
    event.preventDefault(); // Prevent default form submission
    const form = event.target;

    fetch(form.action, {
      method: form.method,
      body: new FormData(form),
      headers: {
        'Accept': 'application/json'
      }
    })
    .then(response => {
      if (response.ok) {
        // Handle successful response
        return response.json(); // Parse JSON response
      } else {
        // Handle error response
        console.error('Failed to save notes');
        throw new Error('Failed to save notes');
      }
    })
    .then(data => {
      // Handle JSON data
      console.log('Notes saved successfully:', data);
      this.element.outerHTML = data.notes
    })
    .catch(error => {
      console.error('An error occurred:', error);
    });
  }
}

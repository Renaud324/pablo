import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="interaction"
export default class extends Controller {
  static targets = ['form']
  static values = { applicationId: Number }

  connect() {
    console.log('hello')
  }

  async create(evt) {
    evt.preventDefault();

    const options = {
      method: "POST", // Could be dynamic with Stimulus values
      headers: { "Accept": "application/json" },
      body: new FormData(this.formTarget)
    }

    const response = await fetch(`/job_applications/${this.applicationIdValue}/interactions`, options)
    const data = await response.json();

    if (data.status == 'ok') {
      // close modal behavior
      this.formTarget.classList.remove("show");
        this.formTarget.style.display = "none";
    } else {
      this.element.innerHTML = data.html
    }
  }
}

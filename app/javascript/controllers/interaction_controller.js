import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="interaction"
export default class extends Controller {
  static targets = ['form']
  static values = { id: Number }

  connect() {
    console.log('hello')
    console.log(this.idValue)
  }

  create(evt) {
    evt.preventDefault();
    console.log(document.getElementById('modal').dataset.interactionIdValue)

    fetch(`/job_applications/${document.getElementById('modal').dataset.interactionIdValue}/interactions`, {
      method: "POST", // Could be dynamic with Stimulus values
      headers: { "Accept": "application/json" },
      body: new FormData(this.formTarget)
    })
    .then((response) => response.json())
    .then((data) => {
      if (data.status == 'ok') {
        // close modal behavior
        this.closeModal()
      } else {
        this.formTarget.innerHTML = data.html
      }
    })
  }

  closeModal() {
    if (this.element) {
        document.querySelector('body').classList.remove('modal-open');
        document.querySelector('body').style.overflow = "auto";
        this.element.classList.remove('show');
        this.element.setAttribute('aria-hidden', 'true');
        this.element.style.display = 'none';
        var modalBackdrop = document.getElementsByClassName('modal-backdrop')[0];
        if (modalBackdrop) {
            modalBackdrop.remove();
        }
    }
  }
}

import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="interaction"
export default class extends Controller {
  static targets = ['form', 'calendar', 'applications', 'modal']
  static values = { id: Number }

  connect() {
    console.log('hello')
    console.log(this.idValue)
    console.log(this.formTarget)
  }

  create(evt) {
    evt.preventDefault();
    // console.log(document.getElementById('modal').dataset.interactionIdValue)

    fetch(`/interactions`, {
      method: "POST", // Could be dynamic with Stimulus values
      headers: { "Accept": "application/json" },
      body: new FormData(this.formTarget)
    })
    .then((response) => response.json())
    .then((data) => {
      if (data.status == 'ok') {
        console.log(data.form)
        if (data.page == "calendar") {
          this.formTarget.outerHTML = data.form
          this.calendarTarget.innerHTML = data.html
        } else {
          this.formTarget.outerHTML = data.form
          this.applicationsTarget.innerHTML = data.html
        }
        this.closeModal()
      } else {
        this.formTarget.innerHTML = data.html
      }
    })
  }

  closeModal() {
    if (this.modalTarget) {
        document.querySelector('body').classList.remove('modal-open');
        document.querySelector('body').style.overflow = "auto";
        this.modalTarget.classList.remove('show');
        this.modalTarget.setAttribute('aria-hidden', 'true');
        this.modalTarget.style.display = 'none';
        var modalBackdrop = document.getElementsByClassName('modal-backdrop')[0];
        if (modalBackdrop) {
            modalBackdrop.remove();
        }
    }
  }
}

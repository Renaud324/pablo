import { Controller } from "@hotwired/stimulus";
import Sortable from "sortablejs";

export default class extends Controller {
  static targets = ["column1", "column2", "column3", "column4", "count", "offerMessage"];

  connect() {
    this.sortableColumns = [this.column1Target, this.column2Target, this.column3Target, this.column4Target].map((column, index) => {
      return new Sortable(column, {
        group: 'shared', // same group
        animation: 150,
        onEnd: this.updateJobApplicationStatus.bind(this)
      });
    });
  }

  async updateJobApplicationStatus(event) {
    event.preventDefault();
    const item = event.item;
    const id = item.dataset.id;
    const oldColumnId = event.from.dataset.id;
    const newColumnId = event.to.dataset.id;
    const response = await this.sendUpdateRequest(id, newColumnId);
    if (response.ok) {
      const data = await response.json();
      console.log(data);
      this.updateCounts(oldColumnId, newColumnId);
      this.checkOfferColumn();
    } else {
      console.error('Request failed with status:', response.status);
    }
  }

  async sendUpdateRequest(id, status) {
    const statusNumber = parseInt(status, 10);
    return fetch(`/job_applications/${id}`, {
      method: 'PUT',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
      },
      body: JSON.stringify({ job_application: { status: statusNumber } })
    });
  }

  updateCounts(oldColumnId, newColumnId) {
    if (oldColumnId !== newColumnId) {
      this.decrementCount(oldColumnId);
      this.incrementCount(newColumnId);
    }
  }

  checkOfferColumn() {
    const offerColumn = this.column4Target;
    const offerCards = offerColumn.querySelectorAll('.job-card'); // Assurez-vous que cette classe correspond à celle de vos cartes.
    const offerMessage = offerColumn.querySelector('.empty-offer-message'); // Cette classe doit correspondre à celle de votre message/image.
  
    // Vérifiez si l'élément offerMessage est présent dans le DOM
    if (!offerMessage) return;
  
    if (offerCards.length === 0 && offerMessage.classList.contains('hidden')) {
      offerMessage.classList.remove('hidden');
    } else if (offerCards.length !== 0 && !offerMessage.classList.contains('hidden')) {
      offerMessage.classList.add('hidden');
    }
  }
  
  
  decrementCount(columnId) {
    const countTarget = this.countTargets.find(target => target.dataset.id === columnId);
    if (countTarget) {
      let count = parseInt(countTarget.textContent, 10);
      countTarget.textContent = count > 0 ? count - 1 : 0;
    }
  }

  incrementCount(columnId) {
    const countTarget = this.countTargets.find(target => target.dataset.id === columnId);
    if (countTarget) {
      let count = parseInt(countTarget.textContent, 10);
      countTarget.textContent = count + 1;
    }
  }
}

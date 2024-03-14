import { Controller } from "@hotwired/stimulus";
import Sortable from "sortablejs";

export default class extends Controller {

  static targets = ["column1", "column2", "column3", "column4"];

  connect() {
    this.sortableColumns = [this.column1Target, this.column2Target, this.column3Target, this.column4Target].map((column) => {
      return new Sortable(column, {
        group: 'shared', // same group
        animation: 150,
        onEnd: this.updateJobApplicationStatus.bind(this)
      });
    });    
  }

  async updateJobApplicationStatus(event){
    event.preventDefault();
    const item = event.item;
    const id = item.dataset.id; 
    const columnId = item.parentElement.dataset.id;
    const columnIdNumber = parseInt(columnId, 10); // because columnId was a string, model was expecting an integer
    console.log("ici");
    const response = await fetch(`/job_applications/${id}`, {
      method: 'PUT',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
      },
      body: JSON.stringify({ job_application: { status: columnIdNumber } })
    })
    // remove empty message if needed
    console.log("ici2");
    if (response.ok) {
      const data = await response.json();
      console.log(data);
      const columnOffer = this.column4Target;
      const isEmpty = columnOffer.children.length === 0;
      const emptyMessageContainer = columnOffer.querySelector('.empty-offer-message');
      if (isEmpty && !emptyMessageContainer) {
        const messageHtml = `
          <div class="empty-offer-message d-flex gap-4">
            <img src="https://res.cloudinary.com/dkr1l2a2k/image/upload/v1710236245/52d6fd4d-f801-477e-9a88-0216ac81632e_xkxngc.png" alt="Empty" style="height: 70px; width: 70px;">
            <p class="quote mt-3">Keep pushing darling!</p>
          </div>
        `;
        columnOffer.innerHTML += messageHtml;
      } else if (!isEmpty && emptyMessageContainer) {
        emptyMessageContainer.remove();
      }    
    } else {
      console.error('Request failed with status:', response.status);
    }
    console.log("la");
  }
}

import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["card"];

  connect() {
    this.cardTargets.forEach(card => {
      card.addEventListener("dragstart", this.dragStart.bind(this));
      card.addEventListener("dragover", this.dragOver.bind(this));
      card.addEventListener("drop", this.drop.bind(this));
    });
  }

  dragStart(event) {
    event.dataTransfer.setData("text/plain", event.target.dataset.index);
  }

  dragOver(event) {
    event.preventDefault();
  }

  drop(event) {
    event.preventDefault();
    const index = event.dataTransfer.getData("text/plain");
    const card = document.querySelector(`[data-index='${index}']`);
    const container = event.target.closest(".container");
    container.insertBefore(card, event.target);
  }
}

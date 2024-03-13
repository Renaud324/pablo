import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="application-tab"
export default class extends Controller {
  static targets = ["tasktogglableElement","applicationtogglableElement","companytogglableElement","contacttogglableElement","eventtogglableElement"]

  connect() {
    console.log("ApplicationTabController connected")
  }

  fireall(event) {
    event.preventDefault(); // Prevent the default anchor behavior
    console.log("Firing the all event")
    this.tasktogglableElementTarget.classList.remove("d-none");
    this.applicationtogglableElementTarget.classList.remove("d-none");
    this.companytogglableElementTarget.classList.remove("d-none");
    this.contacttogglableElementTarget.classList.remove("d-none");
    this.eventtogglableElementTarget.classList.remove("d-none");
  }


  firetask(event) {
    event.preventDefault(); // Prevent the default anchor behavior
    console.log("Firing the task event")
    this.tasktogglableElementTarget.classList.remove("d-none");
    this.applicationtogglableElementTarget.classList.add("d-none");
    this.companytogglableElementTarget.classList.add("d-none");
    this.contacttogglableElementTarget.classList.add("d-none");
    this.eventtogglableElementTarget.classList.add("d-none");
  }

  fireapplication(event) {
    event.preventDefault(); // Prevent the default anchor behavior
    console.log("Firing the application event")
    this.applicationtogglableElementTarget.classList.remove("d-none");
    this.tasktogglableElementTarget.classList.add("d-none");
    this.companytogglableElementTarget.classList.add("d-none");
    this.contacttogglableElementTarget.classList.add("d-none");
    this.eventtogglableElementTarget.classList.add("d-none");
  }

  firecompany(event) {
    event.preventDefault(); // Prevent the default anchor behavior
    console.log("Firing the company event")
    this.companytogglableElementTarget.classList.remove("d-none");
    this.applicationtogglableElementTarget.classList.add("d-none");
    this.tasktogglableElementTarget.classList.add("d-none");
    this.contacttogglableElementTarget.classList.add("d-none");
    this.eventtogglableElementTarget.classList.add("d-none");
  }

  firecontact(event) {
    event.preventDefault(); // Prevent the default anchor behavior
    console.log("Firing the contact event")
    this.contacttogglableElementTarget.classList.remove("d-none");
    this.applicationtogglableElementTarget.classList.add("d-none");
    this.companytogglableElementTarget.classList.add("d-none");
    this.eventtogglableElementTarget.classList.add("d-none");
    this.tasktogglableElementTarget.classList.add("d-none");
  }

  fireevent(event) {
    event.preventDefault(); // Prevent the default anchor behavior
    console.log("Firing the event event")
    this.eventtogglableElementTarget.classList.remove("d-none");
    this.applicationtogglableElementTarget.classList.add("d-none");
    this.companytogglableElementTarget.classList.add("d-none");
    this.contacttogglableElementTarget.classList.add("d-none");
    this.tasktogglableElementTarget.classList.add("d-none");
  }

}

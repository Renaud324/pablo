import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="activetab"
export default class extends Controller {
  static targets = [
    "alltabElement",
    "applicationtabElement",
    "companytabElement",
    "contacttabElement",
    "eventtabElement",
    "tasktabElement",
]
  connect() {
    console.log("ActiveTabController connected")
  }

alltabElement
applicationtabElement
companytabElement
contacttabElement
eventtabElement
tasktabElement
  fireall(event) {
    event.preventDefault(); // Prevent the default anchor behavior
    console.log("Firing the all event")
    this.alltabElementTarget.classList.add("active");
    this.applicationtabElementTarget.classList.remove("active");
    this.companytabElementTarget.classList.remove("active");
    this.contacttabElementTarget.classList.remove("active");
    this.eventtabElementTarget.classList.remove("active");
    this.tasktabElementTarget.classList.remove("active");
  }

  firetask(event) {
    event.preventDefault(); // Prevent the default anchor behavior
    console.log("Firing the all event")
    this.tasktabElementTarget.classList.add("active");
    this.alltabElementTarget.classList.remove("active");
    this.applicationtabElementTarget.classList.remove("active");
    this.companytabElementTarget.classList.remove("active");
    this.contacttabElementTarget.classList.remove("active");
    this.eventtabElementTarget.classList.remove("active");
  }

  fireapplication(event) {
    event.preventDefault(); // Prevent the default anchor behavior
    console.log("Firing the all event")
    this.applicationtabElementTarget.classList.add("active");
    this.alltabElementTarget.classList.remove("active");
    this.companytabElementTarget.classList.remove("active");
    this.contacttabElementTarget.classList.remove("active");
    this.eventtabElementTarget.classList.remove("active");
    this.tasktabElementTarget.classList.remove("active");
  }


  firecompany(event) {
    event.preventDefault(); // Prevent the default anchor behavior
    console.log("Firing the all event")
    this.companytabElementTarget.classList.add("active");
    this.applicationtabElementTarget.classList.remove("active");
    this.alltabElementTarget.classList.remove("active");
    this.contacttabElementTarget.classList.remove("active");
    this.eventtabElementTarget.classList.remove("active");
    this.tasktabElementTarget.classList.remove("active");
  }

  firecontact(event) {
    event.preventDefault(); // Prevent the default anchor behavior
    console.log("Firing the all event")
    this.contacttabElementTarget.classList.add("active");
    this.applicationtabElementTarget.classList.remove("active");
    this.companytabElementTarget.classList.remove("active");
    this.alltabElementTarget.classList.remove("active");
    this.eventtabElementTarget.classList.remove("active");
    this.tasktabElementTarget.classList.remove("active");
  }


  fireevent(event) {
    event.preventDefault(); // Prevent the default anchor behavior
    console.log("Firing the all event")
    this.eventtabElementTarget.classList.add("active");
    this.applicationtabElementTarget.classList.remove("active");
    this.companytabElementTarget.classList.remove("active");
    this.contacttabElementTarget.classList.remove("active");
    this.alltabElementTarget.classList.remove("active");
    this.tasktabElementTarget.classList.remove("active");
  }

}

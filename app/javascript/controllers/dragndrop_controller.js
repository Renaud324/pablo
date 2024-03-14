import { Controller } from "@hotwired/stimulus";
import Sortable from "sortablejs";

export default class extends Controller {

  static targets = ["column1", "column2", "column3"];

  connect() {
    console.log("Drag and drop controller connected");
    
  }

  click(event){
    event.preventDefault();
    console.log("clicked column" + event.target.id);
  }
}

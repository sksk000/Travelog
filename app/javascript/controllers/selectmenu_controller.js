import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="selectmenu"
export default class extends Controller {
  static targets = ["click", "selects", "inputselect"]

  connect() {}

  addSelect(){
    const inputselect = this.inputselectTarget.value
    this.createBadge(inputselect)
  }

  getSelects(){
    console.log("getSelects()")
    const selectElements = this.selectsTarget.getElementsByClassName("badge")
    console.log(selectElements)
    console.log(Array.from(selectElements).map(selectElement => selectElement.textContent.trim()))
    return Array.from(selectElements).map(selectElement => selectElement.textContent.trim())
  }


  createBadge(value){
    const inputselect = value
    console.log(inputselect)
    const selectElement = document.createElement("span");
    selectElement.className = "badge badge-pill badge-secondary"
    selectElement.textContent = inputselect;
    const selects  = Array.from(this.selectsTarget.children).map(selectElement => selectElement.textContent.trim());
    console.log(selects)
    if(selects.includes(inputselect)){
      alert("同じタグが存在します")
      return
    }

    this.selectsTarget.appendChild(selectElement);
  }

}

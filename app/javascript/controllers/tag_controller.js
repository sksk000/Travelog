import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="tag"
export default class extends Controller {
  static targets = ["input", "tags"]

  initialize() {
    this.element[this.identifier] = this
  }

  connect() {
  }

  addTag(e){

    const inputtag = this.inputTarget.value

    console.log(inputtag)

    const tags  = Array.from(this.tagsTarget.children).map(tagElement => tagElement.textContent.trim());

    if(tags.includes(inputtag)){
      alert("同じタグが存在します")
      return
    }

    this.addTagElement(inputtag)
    this.inputTarget.value = ""

  }

  addTagElement(tag){
    const tagElement = document.createElement("span");
    tagElement.className = "badge badge-pill badge-secondary"
    tagElement.textContent = tag;
    this.tagsTarget.appendChild(tagElement);
  }

  getTags(){
    console.log("getTags()")
    const tagElements = this.tagsTarget.getElementsByClassName("badge")
    console.log(Array.from(tagElements).map(tagElement => tagElement.textContent.trim()))
    return Array.from(tagElements).map(tagElement => tagElement.textContent.trim())
  }

}

import { Controller } from "@hotwired/stimulus"
import { validTagForm } from "../packs/validation";

// Connects to data-controller="tag"
export default class extends Controller {
  static targets = ["input", "tags", "delete"]

  initialize() {
    this.element[this.identifier] = this
  }

  connect() {
  }

  addTag(e){

    const inputtag = this.inputTarget.value
    this.addTagHTML(inputtag)

  }

  addTagElement(tag){
    const tagElement = document.createElement("span");
    tagElement.className = "badge badge-pill badge-primary"
    tagElement.textContent = tag;

     // バツボタンの作成
    const deleteButton = document.createElement("div");
    deleteButton.className = "fa-solid fa-circle-xmark ml-4 deleteTagButton";
    deleteButton.setAttribute("data-action", "click->tag#deleteTag");
    deleteButton.setAttribute("data-tag-target", "delete");

    // タグ要素にバツボタンを追加
    tagElement.appendChild(deleteButton);

    this.tagsTarget.appendChild(tagElement);
  }

  getTags(){
    console.log("getTags()")
    const tagElements = this.tagsTarget.getElementsByClassName("badge")
    console.log(Array.from(tagElements).map(tagElement => tagElement.textContent.trim()))
    return Array.from(tagElements).map(tagElement => tagElement.textContent.trim())
  }

  addTagHTML(value){
    const inputtag = value

    const tags  = Array.from(this.tagsTarget.children).map(tagElement => tagElement.textContent.trim());

    if(!validTagForm(tags, inputtag)){
      return
    }
    this.addTagElement(inputtag)
    this.inputTarget.value = ""
  }

  deleteTag(e){
    const tagElement = e.target.closest("span"); // 親のバッヂ要素を取得
    if (tagElement) {
      tagElement.remove(); // 要素を削除
    }
  }



}

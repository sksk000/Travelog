import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="selectmenu"
export default class extends Controller {
  static targets = ["click", "selects", "inputselect", "delete"]

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
    selectElement.className = "badge badge-pill badge-primary"
    selectElement.textContent = inputselect;
    const selects  = Array.from(this.selectsTarget.children).map(selectElement => selectElement.textContent.trim());
    console.log(selects)
    if(selects.includes(inputselect)){
      alert("同じタグが存在します")
      return
    }

    // バツボタンの作成
    const deleteButton = document.createElement("div");
    deleteButton.className = "fa-solid fa-circle-xmark ml-4 deleteTagButton";
    deleteButton.setAttribute("data-action", "click->selectmenu#deleteBadge");
    deleteButton.setAttribute("data-tag-target", "delete");

    // タグ要素にバツボタンを追加
    selectElement.appendChild(deleteButton);

    this.selectsTarget.appendChild(selectElement);
  }

  deleteBadge(e){
    const tagElement = e.target.closest("span"); // 親のバッヂ要素を取得
    if (tagElement) {
      tagElement.remove(); // 要素を削除
    }
  }

}

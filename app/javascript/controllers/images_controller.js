import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="images"
export default class extends Controller {

  static targets = ["drop", "error", "preview", "select","form"]


  connect() {}

  dragOver(e) {
    console.log("dragover")
    e.preventDefault()
    this.dropTarget.classList.add("bg-secondary")
  }

  dragLeave(e) {
    console.log("dragleave")
    e.preventDefault()
    this.dropTarget.classList.remove("bg-secondary")
  }

  dropImages(e){
    console.log("dropImages")
    e.preventDefault()
    const files = e.dataTransfer.files

    if (files.length > 1) {
      alert("画像は1枚のみアップロード可能です。")
      return
    }

    if(this.checkImageSize(files[0])){
      alert("ファイルサイズの上限2MBを超えている画像はアップロードできません。")
      return
    }
    //ファイル保存
    this.file = files[0]

    //ドラッグアンドドロップした画像をプレビュー表示する
    this.previewImage(this.file)
  }

  checkImageSize(file){
    return ((file.size / 1000) > 2000 ) ? true : false
  }

  submitForm(e){
    e.preventDefault()
    const formData = new FormData(this.formTarget)

    if(this.file){
      formData.append("post[image]", this.file)
    }

    fetch(this.formTarget.action, {
      method: "POST",
      body: formData,
      headers: {
        "X-CSRF-Token": document.querySelector("[name='csrf-token']").content
      }
      })
      .then(response => {
        if (!response.ok) {
          throw new Error("Failed to upload image");
        }
        return response.json();
      })
      .then(data => {
        console.log(data); // サーバーからのレスポンスを処理
      })
      .catch(error => {
        console.error("Error:", error);
      })
  }

  previewImage(file){
    const reader = new FileReader()

    reader.onload = (e)=>{
      const img = document.createElement("img")
      img.src = e.target.result
      img.classList.add("img-thumbnail")
      this.previewTarget.innerHTML = "" 
      this.previewTarget.appendChild(img)
    }
    reader.readAsDataURL(file)
  }


}

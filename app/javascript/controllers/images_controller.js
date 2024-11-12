import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="images"
export default class extends Controller {

  static targets = ["drop", "error", "preview", "select","form", "tags", "selectbox", "selects"]

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

    const tagController = this.application.getControllerForElementAndIdentifier(
      this.element.querySelector('[data-controller="tag"]'),
      "tag"
    );

    if(tagController){
      console.log("タグコントローラが見つかった")
      const tags = tagController.getTags()
      console.log(tags)
      tags.forEach((tag) => {
        formData.append(`tag[name][]`, tag)
      })
    }
    else{
      alert("tagControllerが見つかりません");
    }

    const selectController = this.application.getControllerForElementAndIdentifier(
      this.element.querySelector('[data-controller="selectmenu"]'),
      "selectmenu"
    );

    if(selectController){
      console.log("セレクトコントローラが見つかった")

      const selects = selectController.getSelects()
      console.log(selects)

      selects.forEach((prefecture) => {
        formData.append(`prefecture[prefecture][]`, prefecture)
      })
    }



    //PostモデルのPOSTを行う
    fetch(this.formTarget.action, {
      method: "POST",
      body: formData,
      headers: {
        "X-CSRF-Token": document.querySelector("[name='csrf-token']").content
      }
      }).then((response) => {
      if (!response.ok) {
        // ステータスコードとエラーメッセージをログに出力
        console.error(`Error: ${response.status} - ${response.statusText}`);
        return response.text(); // レスポンスのテキストを取得
      }
      console.log("投稿成功");
      return response.json(); // 正常の場合はJSONレスポンスを処理
    })
    .then((data) => {
      if (data && data.error) {
        alert("投稿に失敗しました: " + data.error);
      }
    })
    .catch((error) => {
      console.error("Fetchエラー:", error);
      alert("投稿に失敗しました");
    });

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

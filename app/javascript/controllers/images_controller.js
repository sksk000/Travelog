import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="images"
export default class extends Controller {

  static targets = ["drop", "error", "preview", "select","form", "tags", "selectbox", "selects", "submit"]

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

    if(!this.validateForm()){
      this.submitTarget.blur()
      return
    }

    if(this.file){
      formData.append("post[image]", this.file)
    }

    const tagController = this.application.getControllerForElementAndIdentifier(
      this.element.querySelector('[data-controller="tag"]'),
      "tag"
    );

    const selectController = this.application.getControllerForElementAndIdentifier(
      this.element.querySelector('[data-controller="selectmenu"]'),
      "selectmenu"
    );

    if(tagController){
      const tags = tagController.getTags()
      tags.forEach((tag) => {
        formData.append(`tag[name][]`, tag)
      })
    }
    else{
      alert("tagControllerが見つかりません");
      this.submitTarget.blur()
    }

    if(selectController){

      const selects = selectController.getSelects()

      if(selects.length < 1){
        alert("旅行した都道府県を最低1つ選択してください")
        this.submitTarget.blur()
        return
      }

      selects.forEach((prefecture) => {
        formData.append(`prefecture[prefecture][]`, prefecture)
      })

    }

    const actionURL = this.formTarget.action.endsWith('.json') ? this.formTarget.action : this.formTarget.action + '.json';

    //PostモデルのPOSTを行う
    fetch(actionURL, {
      method: "POST",
      body: formData,
      headers: {
        "X-CSRF-Token": document.querySelector("[name='csrf-token']").content
      }
      }).then((response) => {
      if (!response.ok) {
        this.submitTarget.blur()
        return response.text(); // レスポンスのテキストを取得
      }
      console.log("投稿成功");
      return response.json(); // 正常の場合はJSONレスポンスを処理
    })
    .then((data) => {
      if (data && data.error) {
        alert("投稿に失敗しました: " + data.error);
        this.submitTarget.blur()
        return
      }

      if(data.redirect_url){
        window.location.href = data.redirect_url;
      }else{
        alert("リダイレクトURLが含まれていません");
        this.submitTarget.blur()
        return
      }
    })
    .catch((error) => {
      alert("投稿に失敗しました");
      this.submitTarget.blur()
      return
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


  validateForm(){

    let errormsg = ""
    let isSuccess = true

    const title = this.formTarget.querySelector('[name="post[title]"]');
    const body = this.formTarget.querySelector('[name="post[body]"]');


    // タイトルと投稿内容が空でないかチェック
    if(!title.value.trim()){
      errormsg = errormsg + "タイトルが空欄です\n"
      isSuccess = isSuccess && false
    }

    if (!body.value.trim()) {
      errormsg = errormsg + "投稿内容が空欄です\n"
      isSuccess = isSuccess && false
    }

    if(isSuccess){
      return true
    } else {
      alert(errormsg)
    }


  }
}

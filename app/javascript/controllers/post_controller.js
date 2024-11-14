import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="post"
export default class extends Controller {
  connect() {
  }

  static targets = ["drop", "error", "preview", "select","form", "tags", "selectbox", "selects", "submit"]

  submitForm(e){
    e.preventDefault()
    const formData = new FormData(this.formTarget)

    if(!this.validateForm()){
      this.submitTarget.blur()
      return
    }

    const tagController = this.application.getControllerForElementAndIdentifier(
      this.element.querySelector('[data-controller="tag"]'),
      "tag"
    );

    const selectController = this.application.getControllerForElementAndIdentifier(
      this.element.querySelector('[data-controller="selectmenu"]'),
      "selectmenu"
    );

    const imageController = this.application.getControllerForElementAndIdentifier(
      this.element.querySelector('[data-controller="images"]'),
      "images"
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

    if(imageController){
      const image = imageController.getImage()
      console.log(image)
      if(image){
        formData.append("post[image]", image)
      }
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

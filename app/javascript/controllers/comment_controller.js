import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="comment"
export default class extends Controller {
  connect() {
  }

  static targets = ["form", "commentindex"]


  submitForm(e){
    const formData = new FormData(this.formTarget)
    const nestedData = {
      comment: {
        comment: formData.get("comment"),
      },
    };

    if(!this.validForm(nestedData.comment)){
      return
    }

     const response = fetch(this.formTarget.action,{
       method: "POST",
       body: JSON.stringify(nestedData),
       headers: {
        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').getAttribute("content"),
        "Content-Type": "application/json",
      },
    })
      .then((response) => {
      if (!response.ok) {
        alert("投稿失敗しました")
      }
      return response.text(); // HTMLテンプレートをテキストとして取得
    })
    .then((html) => {
      console.log(html)
      // 部分テンプレートをページに反映する
      this.commentindexTarget.insertAdjacentHTML('afterbegin',html)
    })
    .catch((error) => {
      console.error("Error:", error);
    });

  }

  validForm(datas){
    if( datas.comment.length == 0){
      alert("コメントが入力されていません")
      return false
    }
    return true
  }

}

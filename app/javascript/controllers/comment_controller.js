import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="comment"
export default class extends Controller {
  connect() {
  }

  static targets = ["form", "commentindex", "destroy"]


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
        return response.json();
      }
      return response.json(); // HTMLテンプレートをテキストとして取得
    })
    .then((json) => {
      console.log(json)

      if(json.redirect_url){
        alert("ログインしてください")
        window.location.href = json.redirect_url
      }

      if(json.html){
        // 部分テンプレートをページに反映する
        this.commentindexTarget.insertAdjacentHTML('afterbegin',json.html)
      }

      })
    .catch((error) => {
      console.error("エラー:", error.message);
    });

  }

  validForm(datas){
    if( datas.comment.length == 0){
      alert("コメントが入力されていません")
      return false
    }
    return true
  }


  deleteComment(e){
    event.preventDefault();

    if(!confirm("コメントを削除しますか？")){
      return
    }


    const commentid = event.target.dataset.commentid;
    const postid = event.target.dataset.postid;
    const url = `/posts/${postid}/comments/${commentid}`;


    const response = fetch(url,{
       method: "DELETE",
       headers: {
        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').getAttribute("content"),
        "Content-Type": "application/json",
      },
    })
    .then(response => response.json())
    .then((json) => {
      console.log(json.html)
       if (json.html) {
          this.element.innerHTML = json.html;
        } else {
          alert('コメント削除に失敗しました');
      }
    })
    .catch((error) => {
      console.error("エラー:", error.message);
    });

  }

}

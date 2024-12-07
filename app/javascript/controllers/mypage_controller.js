import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="mypage"
export default class extends Controller {
  connect() {
  }

  static targets = ["select", "postContainer"]


  updatePostIndex(e){

    const selectedValue = this.selectTarget.value; // 選択された値を取得
    const url = `/mypage/${this.element.dataset.userId}/post_index?select=${selectedValue}`; // GETリクエストのURLを生成

   fetch(url, { headers: { "Accept": "text/html" } })
      .then(response => response.text())
      .then(html => {
        console.log(html)

        this.postContainerTarget.innerHTML = html
      });
  }

}

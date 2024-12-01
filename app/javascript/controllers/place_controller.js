import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="place"
export default class extends Controller {
  connect() {
  }

  static targets = ["submit", "form"]

  submitForm(e){
    e.preventDefault()

    const formData = new FormData()
    console.log(window.tabdatas)

    const tabdatas = window.tabdatas

    if(!this.validForm(tabdatas.locations)){
      this.submitTarget.blur()
      return
    }

/*
    tabdatas.locations.forEach((data, index) =>{
      formData.append(`place[${index}][place_name]`, data.name);
      formData.append(`place[${index}][latitude]`, String(data.location.lat));
      formData.append(`place[${index}][longitude]`, String(data.location.lng));
      formData.append(`place[${index}][comment]`, data.comment);
      formData.append(`place[${index}][good]`, data.rating);
      formData.append(`place[${index}][place_num]`, index);

      if(data.image){
        formData.append(`place[${index}][image]`, data.image);
      }
    })
  */

  console.log(tabdatas)


    //PostモデルのPOSTを行う
    fetch(this.formTarget.action, {
      method: "POST",
      body: JSON.stringify({ place: tabdatas.locations }), // 配列をそのまま送信
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': document.querySelector("[name='csrf-token']").content
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

  validForm(datas){
    let errormsg = ""
    let isSuccess = true

    console.log(datas)
    datas.forEach((data, index)=>{
      // 訪問地名が保存されているか確認する
      if(!data.place_name.trim()){
        errormsg = errormsg + "訪問地名が空欄です\n"
        isSuccess = isSuccess && false
      }

    })


    if(isSuccess){
        return true
    } else {
      alert(errormsg)
    }
  }
}

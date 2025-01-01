import { Controller } from "@hotwired/stimulus"
import { validEditForm } from "../packs/validation";
import  toastr from 'toastr';

// Connects to data-controller="user"
export default class extends Controller {
  connect() {

    const userId = this.element.dataset.id
    if(userId){
      this.loadData(`/mypage/${this.element.dataset.id}/edit`);
    }

    this.image = null

    this.pushprofile()
    this.showProfile()
  }

  static targets = ["delete", "profile", "user", "updateinfo", "updateprof", "template", "profileform", "infoform"]

  renderProfile(e){
    this.pushprofile()
    this.showProfile()
  }

  renderUserSetting(e){
    this.pushuserinfo()
    this.showInfo()
  }


  submitProfile(e){
    this.fetchData( this.profileformTarget )
  }

  submitInfo(e){
    this.fetchData( this.infoformTarget )
  }

  async loadData(actionURL){
    const url = actionURL; // GETリクエストのURLを生成

    const response = await fetch(url, {headers: {'Accept': 'application/json'}});
    if (!response.ok) throw new Error('Network response was not ok');
    const json = await response.json();

    if(json){
      console.log(json)

      if(json.html){
        this.templateTarget.innerHTML = json.html
      }
      if(json.image_url && this.image == null){
        const imageController = this.application.getControllerForElementAndIdentifier(
        this.element.querySelector('[data-controller="images"]'),
          "images"
        );

        if(imageController){
          console.log("called")
          imageController.previewImage(json.image_url)
        }
      }
    }
  }

  showInfo(){
    this.infoformTarget.style.display = "block"
    this.profileformTarget.style.display = "none"
  }

  showProfile(){
    this.infoformTarget.style.display = "none"
    this.profileformTarget.style.display = "block"
  }

  fetchData( formtarget ){
    const formData = new FormData(formtarget)

    const imageController = this.application.getControllerForElementAndIdentifier(
      this.element.querySelector('[data-controller="images"]'),
      "images"
    );

    let image = null
    if(imageController){
      image = imageController.getImage()
    }

    if(image){
      formData.append(`user[profile_image]`, image)
    }

    if(!validEditForm()){
      return
    }

    const actionURL = `/users`
    fetch(actionURL, {
      method: "PATCH",
      body: formData,
      headers: {
        "X-CSRF-Token": document.querySelector("[name='csrf-token']").content
      }
      }).then((response) => {
      if (!response.ok) {
        console.log("!response.ok")
        toastr.error("ユーザ情報更新に失敗しました")
        this.updateprofTarget.blur()
        this.updateinfoTarget.blur()
        return
      }
      // レスポンスをJSONとしてパース
      response.json().then((data) => {
        if (data.message) {
          toastr.success(data.message);
        }
      });

      return;
    })
    .catch((error) => {
      console.log(error);
        this.updateprofTarget.blur()
        this.updateinfoTarget.blur()
      return
    });

  }

  pushprofile(){
    this.profileTarget.classList.add("active")
    this.userTarget.classList.remove("active")
  }

  pushuserinfo(){
    this.profileTarget.classList.remove("active")
    this.userTarget.classList.add("active")
  }

  withdrawUser(e){

    let isWithdraw = confirm("退会しますか？")
    if(!isWithdraw){
      return
    }

    const actionURL = `/users/withdraw`
    fetch(actionURL, {
      method: "DELETE",
      headers: {
        "X-CSRF-Token": document.querySelector("[name='csrf-token']").content
      }
      }).then((response) => {
      if (!response.ok) {
        toastr.error("削除に失敗しました")
        return response.json();
      }
      return response.json();
    })
    .then((data)=>{
      if(data.redirect_url){
        window.location.href = data.redirect_url;
      }else{
        toastr.error("リダイレクトURLが含まれていません");
        this.submitTarget.blur()
        return
      }
    })
    .catch((error) => {
      toastr.error("削除に失敗しました");
      return
    });
  }

  validForm(){

  }

}

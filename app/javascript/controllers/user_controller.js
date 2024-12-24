import { Controller } from "@hotwired/stimulus"

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


    console.log(this.profileformTarget)

    const actionURL = `/users`
    fetch(actionURL, {
      method: "PATCH",
      body: formData,
      headers: {
        "X-CSRF-Token": document.querySelector("[name='csrf-token']").content
      }
      }).then((response) => {
      if (!response.ok) {
        alert("更新に失敗しました")
        this.updateprofTarget.blur()
        this.updateinfoTarget.blur()
        return
      }
      alert("更新しました");
      return
    })
    .catch((error) => {
      alert("更新に失敗しました");
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

}

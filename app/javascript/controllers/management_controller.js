import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="management"
export default class extends Controller {
  connect() {
    this.showUsers()
  }

  static targets = ["postbtn", "userbtn", "post", "user"]

  showUsers(){
    this.postTarget.style.display = "none"
    this.userTarget.style.display = "block"
  }

  showPosts(){
    this.postTarget.style.display = "block"
    this.userTarget.style.display = "none"
  }


}

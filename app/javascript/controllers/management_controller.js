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

    this.userbtnTarget.style.backgroundColor = "white"
    this.postbtnTarget.style.backgroundColor = "#d3d3d3"
  }

  showPosts(){
    this.postTarget.style.display = "block"
    this.userTarget.style.display = "none"

    this.userbtnTarget.style.backgroundColor = "#d3d3d3"
    this.postbtnTarget.style.backgroundColor = "white"
  }


}

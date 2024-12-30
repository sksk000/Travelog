import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="certification"
export default class extends Controller {
  connect() {
  }

  static targets = ["login", "signin"]

  signinSubmit(e){

    if(!this.validSignForm()){
      event.preventDefault(); // 無効な場合は送信を中断
      event.stopPropagation(); // デフォルト動作を停止
    }
  }


  validSignForm(){
    let ret = true
    const email = document.querySelector(".email")
    const username = document.querySelector(".username")
    const password = document.querySelector(".password")
    const pwdconf = document.querySelector(".password_confirmation")
    const emailvalid = document.querySelector(".email")

    if(!email.checkValidity()){
      email.classList.add("is-invalid");
      email.nextElementSibling.textContent = "有効なメールアドレスを入力してください。";
      ret = false
    }else {
      email.classList.remove("is-invalid");
      email.nextElementSibling.textContent = "";
    }

    if(!password.checkValidity()){
      password.classList.add("is-invalid");
      password.nextElementSibling.textContent = "パスワードを入力してください";
      ret = false
    }else {
      password.classList.remove("is-invalid");
      password.nextElementSibling.textContent = "";
    }

    if(password.value != pwdconf.value){
      pwdconf.classList.add("is-invalid");
      pwdconf.nextElementSibling.textContent = "上記で入力したパスワードと異なります";
      ret = false
    }else {
        pwdconf.classList.remove("is-invalid");
        pwdconf.nextElementSibling.textContent = "";
    }

    if(!username.checkValidity()){
      username.classList.add("is-invalid");
      username.nextElementSibling.textContent = "ユーザ名を入力して下さい";
      ret = false
    }else {
        username.classList.remove("is-invalid");
        username.nextElementSibling.textContent = "";
    }

    return ret
  }


}

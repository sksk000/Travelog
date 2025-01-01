 export function validForm(){
    let ret = true
    const email = document.querySelector(".email")
    const username = document.querySelector(".username")
    const password = document.querySelector(".password")
    const pwdconf = document.querySelector(".password_confirmation")

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

   export function validEditForm(){
    let ret = true
    const email = document.querySelector(".email")
    const username = document.querySelector(".username")
    const password = document.querySelector(".password")
    const pwdconf = document.querySelector(".password_confirmation")

    if(!email.checkValidity()){
      email.classList.add("is-invalid");
      email.nextElementSibling.textContent = "有効なメールアドレスを入力してください。";
      ret = false
    }else {
      email.classList.remove("is-invalid");
      email.nextElementSibling.textContent = "";
    }

    if(password.value != ''){
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



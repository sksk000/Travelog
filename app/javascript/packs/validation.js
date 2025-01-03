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
    }else{
      email.classList.remove("is-invalid");
      email.nextElementSibling.textContent = "";
    }

    if(!password.checkValidity()){
      password.classList.add("is-invalid");
      password.nextElementSibling.textContent = "6文字以上のパスワードを入力してください。";
      ret = false
    }else{
      password.classList.remove("is-invalid");
      password.nextElementSibling.textContent = "";
    }

    if(password.value != pwdconf.value){
      pwdconf.classList.add("is-invalid");
      pwdconf.nextElementSibling.textContent = "上記で入力したパスワードと異なります。";
      ret = false
    }else{
        pwdconf.classList.remove("is-invalid");
        pwdconf.nextElementSibling.textContent = "";
    }

    if(!username.checkValidity()){
      username.classList.add("is-invalid");
      username.nextElementSibling.textContent = "3文字以上のユーザ名を入力してください。";
      ret = false
    }else{
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
    const newpwd = document.querySelector(".newpassword")

    if(!email.checkValidity()){
      email.classList.add("is-invalid");
      email.nextElementSibling.textContent = "有効なメールアドレスを入力してください。";
      ret = false
    }else{
      email.classList.remove("is-invalid");
      email.nextElementSibling.textContent = "";
    }

    if(password.value != ''){
      if(!password.checkValidity()){
        password.classList.add("is-invalid");
        password.nextElementSibling.textContent = "パスワードを入力してください";
        ret = false
      }else{
        password.classList.remove("is-invalid");
        password.nextElementSibling.textContent = "";
      }

      //新しいパスワードと新しいパスワードを再度入力して間違っていないか確認
      if(pwdconf.value != newpwd.value){
        pwdconf.classList.add("is-invalid");
        pwdconf.nextElementSibling.textContent = "上記で入力したパスワードと異なります";
        ret = false
      }else{
          pwdconf.classList.remove("is-invalid");
          pwdconf.nextElementSibling.textContent = "";
      }
    }

    if(!username.checkValidity()){
      username.classList.add("is-invalid");
      username.nextElementSibling.textContent = "ユーザ名を入力して下さい";
      ret = false
    }else{
        username.classList.remove("is-invalid");
        username.nextElementSibling.textContent = "";
    }

    return ret
  }

   export function validPostForm(){

    let isSuccess = true

    const title = document.getElementById("post_title");
    const body = document.getElementById("body-textarea");

    console.log(title)
    console.log(body)


    // タイトルと投稿内容が空でないかチェック
    if(!title.checkValidity()){
      isSuccess = false
      title.classList.add("is-invalid")
      title.nextElementSibling.textContent = "タイトルを入力してください"
    }else{
      title.classList.remove("is-invalid")
      title.nextElementSibling.textContent = ""
    }

    if (!body.checkValidity()) {
      body.classList.add("is-invalid")
      body.nextElementSibling.textContent = "投稿内容を入力してください"
      isSuccess = false
      console.log(body.nextElementSibling)
    }else{
      body.classList.remove("is-invalid")
      body.nextElementSibling.textContent = ""
    }

    console.log(isSuccess)

    return isSuccess
  }

export function validTagForm(tags, value){
  const inputtagform = document.querySelector(".inputtag")
  const validtext = document.getElementById("tag-invalid")
  let ret = true
  if(tags.includes(value)){
    inputtagform.classList.add("is-invalid");
    validtext.textContent = "同じタグが設定されています。";
    validtext.style.display = "block"
    ret = false;
  }else{
    inputtagform.classList.remove("is-invalid");
    validtext.textContent = "";
    validtext.style.display = "none"
  }

  return ret
}

export function validPlaceForm(value){
  let ret = true
  const validtext = document.getElementById("placename-invalid")

  if(value == ""){
    validtext.textContent = "訪問地名が空欄です。"
    validtext.style.display = "block"
    ret = false
  }else{
    validtext.textContent = "";
    validtext.style.display = "none"
  }

  return ret
}




import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="images"
export default class extends Controller {

  static targets = ["drop", "error", "preview", "select","form", "tags", "selectbox", "selects", "submit", "deletebtn"]

  connect() {

  }

  dragOver(e) {
    e.preventDefault()
    this.dropTarget.classList.add("bg-secondary")
    this.dropTarget.classList.remove("bg-white")
  }

  dragLeave(e) {
    e.preventDefault()
    this.dropTarget.classList.remove("bg-secondary")
  }

  dropImages(e){
    e.preventDefault()
    const files = e.dataTransfer.files

    if (files.length > 1) {
      alert("画像は1枚のみアップロード可能です。")
      return
    }

    if(this.checkImageSize(files[0])){
      alert("ファイルサイズの上限2MBを超えている画像はアップロードできません。")
      return
    }
    //ファイル保存
    this.file = files[0]

    //ドラッグアンドドロップした画像をプレビュー表示する
    this.previewImage(this.file)
  }

  checkImageSize(file){
    return ((file.size / 1000) > 2000 ) ? true : false
  }

  previewImage(file){
    console.log(file)
    const img = this.dropTarget.querySelector('img')
    if(img){
      img.remove()
    }
    const imgElement = document.createElement("img")
    imgElement.classList.add("img-fluid")
    imgElement.classList.add("previewImage")
    this.dropTarget.classList.remove("bg-secondary")

    if(file instanceof File){
      const reader = new FileReader()
      const imageinfo = document.getElementById("imageinfo")

      reader.onload = (e)=>{
        imgElement.src = e.target.result
      }
      reader.readAsDataURL(file)
    } else if(typeof file == "string"){
      imgElement.src = file
    }
    this.dropTarget.appendChild(imgElement)
    this.visibleImage(true)

    const createddeletebtn = document.getElementById("deleteimagebtn")
    if(!createddeletebtn){
      //画像削除ボタン用意
      const deletebtn = document.createElement("button")
      deletebtn.classList.add("fa-solid")
      deletebtn.classList.add("fa-circle-xmark")
      deletebtn.setAttribute("data-images-target", "deletebtn")
      deletebtn.setAttribute("data-action", "click->images#deleteImage")
      deletebtn.setAttribute("id", "deleteimagebtn")
      this.dropTarget.appendChild(deletebtn)
    }
  }

  getImage(){
    return this.file
  }

  deleteImage(e){
    e.preventDefault()

    let checkdelete = window.confirm('画像を削除しますか');

    if(checkdelete){
      this.visibleImage(false)
    }else{
      this.visibleImage(true)
    }

  }

  visibleImage(isShow){
    const imageinfo = document.getElementById("imageinfo")
    const imagedata = document.querySelector(".previewImage");
    const deletebtn = document.getElementById("deleteimagebtn")

    if(!isShow){
      imageinfo.style.display = ''

      if(imagedata){
        imagedata.remove()
        console.log("imagedata.remove()")
      }

      if(deletebtn){
        deletebtn.remove()
        console.log("deletebtn.remove()")
      }
      this.file = null
    }
    else{
      imageinfo.style.display = 'none'
    }

  }

}

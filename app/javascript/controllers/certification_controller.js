import { Controller } from "@hotwired/stimulus"
import { validForm } from "../packs/validation";

// Connects to data-controller="certification"
export default class extends Controller {
  connect() {
  }

  static targets = ["login", "signin"]

  signinSubmit(e){
    if(!validForm()){
      event.preventDefault(); // 無効な場合は送信を中断
      event.stopPropagation(); // デフォルト動作を停止
    }
  }

}

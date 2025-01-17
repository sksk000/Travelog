// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

//import "jquery";
import "popper.js";
import "bootstrap";
import "../stylesheets/application";
import "controllers"
import $ from 'jquery';
import toastr from 'toastr';

Rails.start()
Turbolinks.start()
ActiveStorage.start()
window.$ = window.jQuery = $;

import Raty from "./raty.js"
window.raty = function(elem,opt) {
 let raty =  new Raty(elem,opt)
 raty.init();
 return raty;
}

document.addEventListener('turbolinks:load', function() {
  const swiper = new Swiper('.swiper-container', {
    loop: true,
    navigation: {
      nextEl: '.swiper-button-next',
      prevEl: '.swiper-button-prev',
    },
    sliedesPreview: 1
  });

 // 現在のURLパスを取得
  const currentPath = window.location.pathname;

  if (/^\/mypage\/\d+\/edit$/.test(currentPath)) {
    // mainタグにpb-5クラスを追加
    document.querySelector('main').classList.remove('pb-5');
  } else {
    // mainタグからpb-5クラスを削除（他のページであれば）
    document.querySelector('main').classList.add('pb-5');
  }

  // パスが "/posts/ID" の形式の場合
  if ((/^\/posts\/\d+$/.test(currentPath)) || (/^\/posts\/\d+\/places\/\w+/.test(currentPath))) {
    console.log("overflow:hidden")
    document.body.style.overflow = "hidden"; // スクロールを禁止
  }
  else{
    console.log("overflow:none")
    document.body.style.overflow = ""
  }

  const toastData = localStorage.getItem('toastMessage');
    if (toastData) {
      console.log("toastData")
        const { type, message } = JSON.parse(toastData);
        if (type === 'success') {
            toastr.success(message);
        } else if (type === 'error') {
            toastr.error(message);
        }
        localStorage.removeItem('toastMessage');
    }


});

  toastr.options = {
    "positionClass": "toast-top-full-width",
    "closeButton": true,
    "progressBar": true,
  }


window.$ = window.jQuery = require('jquery');
window.toastr = toastr;

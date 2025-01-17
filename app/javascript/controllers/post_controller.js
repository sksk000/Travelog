import { Controller } from "@hotwired/stimulus"
import { validPostForm } from "../packs/validation";
import  toastr from 'toastr';

// ブートストラップ ローダ
(g=>{var h,a,k,p="The Google Maps JavaScript API",c="google",l="importLibrary",q="__ib__",m=document,b=window;b=b[c]||(b[c]={});var d=b.maps||(b.maps={}),r=new Set,e=new URLSearchParams,u=()=>h||(h=new Promise(async(f,n)=>{await (a=m.createElement("script"));e.set("libraries",[...r]+"");for(k in g)e.set(k.replace(/[A-Z]/g,t=>"_"+t[0].toLowerCase()),g[k]);e.set("callback",c+".maps."+q);a.src=`https://maps.${c}apis.com/maps/api/js?`+e;d[q]=f;a.onerror=()=>h=n(Error(p+" could not load."));a.nonce=m.querySelector("script[nonce]")?.nonce||"";m.head.append(a)}));d[l]?console.warn(p+" only loads once. Ignoring:",g):d[l]=(f,...n)=>r.add(f)&&u().then(()=>d[l](f,...n))})({
  key: process.env.Maps_API_Key
});

// Connects to data-controller="post"
export default class extends Controller {
  connect() {
    const element = document.getElementById('post_map')
    const postId = this.element.dataset.postId;
    this.markers = []

    if(element){
      this.initMap()
      this.map = null
    }

    if(postId){
      this.fetchDataPost(postId)
    }

    const body = document.getElementById("body-textarea");
    if(body){
      body.placeholder = "旅行のプランやコンセプトなど、自由に記載してみよう！\n例:) 2泊3日で北海道に行ってきました！歩き中心のプランで疲れましたが、お魚はどれも絶品でした！";
    }

  }

  static targets = ["drop", "error", "preview", "select","form", "tags", "selectbox", "selects", "submit", "placedata"]

  async initMap() {
    const { Map } = await google.maps.importLibrary("maps");
    const {AdvancedMarkerElement} = await google.maps.importLibrary("marker") // 追記


    // 追記
    const element = document.getElementById('post_map');

    const response = await fetch(`/posts/${element.dataset.id}.json`);
    if (!response.ok) throw new Error('Network response was not ok');

    const { data: { items } } = await response.json();

    const target_latitude = items.latitude;
    const target_longitude = items.longitude;

    this.map = new Map(document.getElementById("post_map"), {
      center: { lat: target_latitude, lng: target_longitude },
      zoom: 15,
      mapId: process.env.Maps_API_Key,
      disableDefaultUI: true
    });

    items.places.forEach( (place, index) =>{
      const latitude = place.latitude;
      const longitude = place.longitude;
      const comment  = place.comment;

      const marker = new google.maps.marker.AdvancedMarkerElement ({
        position: { lat: latitude, lng: longitude },
        map: this.map,
        title: comment,
      });

      // 追記
        const contentString = `
          <div class="information container p-0">
            <div class="text-center">
              <img src="${place.image}" class="rounded mx-auto d-block" style="width: 400px; height: auto;">
            </div>
            <div class="mt-3">
              <h5>📍訪問地名:</h5>
              <p class="lead">${place.place_name}</p>
            </div>
            <div class="mt-3">
              <h5>📝感想やメモ:</h5>
              <p class="lead">${comment}</p>
            </div>
            <div class="good mt-3">
              <h5>おすすめ度:</h5>
              <div id="star_place_show_${place.id}" data-star-on="${items.ratyimgpath_on}" data-star-off="${items.ratyimgpath_off}">
              </div>
              <p class="text-muted mt-3">${place.address}</p>
            </div>
          </div>
        `;

        console.log(place.good)

        const infowindow = new google.maps.InfoWindow({
          content: contentString,
          ariaLabel: "aaaa",
        });

        if(index == 0){
          infowindow.open({
            anchor: marker,
            map: this.map,
          })
        }
        console.log(marker)
        this.markers.push(marker)
        console.log(this.markers)

        marker.addListener("click", () => {
            infowindow.open({
            anchor: marker,
            map: this.map,
          })

          setTimeout(() => {
            const elem = document.querySelector(`#star_place_show_${place.id}`);
            if (elem) {
              if (!elem.classList.contains('raty-initialized')) {
                const option = {
                  starOn: elem.dataset.starOn,
                  starOff: elem.dataset.starOff,
                  readOnly: true,
                  score: place.good,
                };
                raty(elem, option);
              }

              elem.classList.add('raty-initialized');
            }
          }, 10); // タイミング調整のため少し遅延させる
        });
    });

  }


  submitForm(e){
    let isfetch = true
    e.preventDefault()
    const formData = new FormData(this.formTarget)

    if(!validPostForm()){
      this.submitTarget.blur()
      isfetch = false
    }

    const tagController = this.application.getControllerForElementAndIdentifier(
      this.element.querySelector('[data-controller="tag"]'),
      "tag"
    );

    const selectController = this.application.getControllerForElementAndIdentifier(
      this.element.querySelector('[data-controller="selectmenu"]'),
      "selectmenu"
    );

    const imageController = this.application.getControllerForElementAndIdentifier(
      this.element.querySelector('[data-controller="images"]'),
      "images"
    );

    if(tagController){
      const tags = tagController.getTags()
      tags.forEach((tag) => {
        formData.append(`tag[name][]`, tag)
      })
    }
    else{
      alert("tagControllerが見つかりません");
      this.submitTarget.blur()
      isfetch = false
    }

    if(selectController){
      const selectValidText = document.getElementById("select-invalid")
      const selects = selectController.getSelects()

      console.log("selectController")

      //都道府県のバリデーションチェック
      if(selects.length < 1){
        selectValidText.textContent = "最低でも1つ訪れた都道府県を追加してください"
        selectValidText.style.display = "block"
        this.submitTarget.blur()
        isfetch = false
      }else{
        selectValidText.textContent = ""
        selectValidText.style.display = "none"
      }

      selects.forEach((prefecture) => {
        formData.append(`prefecture[prefecture][]`, prefecture)
      })

    }

    if(imageController){
      const image = imageController.getImage()
      console.log(image)
      if(image){
        formData.append("post[image]", image)
      }
    }


    if(isfetch){
      const actionURL = this.formTarget.action.endsWith('.json') ? this.formTarget.action : this.formTarget.action + '.json';
      const isEdit = window.location.pathname.includes("/edit");
      const requestMethod = isEdit ? "PATCH" : "POST";

      //PostモデルのPOSTを行う
      fetch(actionURL, {
        method: requestMethod,
        body: formData,
        headers: {
          "X-CSRF-Token": document.querySelector("[name='csrf-token']").content
        }
        }).then((response) => {
          return response.json(); // JSONで受け取るように設定
      })
      .then((data) => {
        if(data && data.redirect_url){
          window.location.href = data.redirect_url;
        }else{
          toastr.error(data.message);
          this.submitTarget.blur()
          return
        }
      })
      .catch((error) => {
        toastr.error("不明なエラーが発生しました。時間を置いて再度お試しください。また解決しない場合は問題が解決しない場合は、サポートまでご連絡ください。")
        console.error("キャッチされたエラー:", error.message);
        this.submitTarget.blur()
        return
      });
    }
  }

  moveMaker(e){

    const lat = e.target.dataset.latitude
    const lng = e.target.dataset.longitude
    const index = Number(e.target.dataset.index)

    console.log(lat)
    console.log(lng)
    this.map.panTo(new google.maps.LatLng(parseFloat(lat),parseFloat(lng)))

    google.maps.event.trigger(this.markers[index], "click");

  }


  async fetchDataPost(id){

    //新規投稿ページの場合は処理を行わない
    const currentPath = window.location.pathname;

    const targetURL = `/posts/${id}/edit`
    if (targetURL != currentPath) {
      console.log("投稿編集以外のページのためfetchしません")
      return
    }

    const response = await fetch(`/posts/${id}/edit.json`);
    if (!response.ok) throw new Error('Network response was not ok');
    const json = await response.json();

    this.loadPostdata(json.data)
  }


  loadPostdata(json){
    console.log(json)

    //raty
    var selectname = '#star_post_edit'
    var elem = document.querySelector(selectname);
    elem.innerHTML = ""
    var option = {
        starOn: json.ratyimgpath_on,
        starOff: json.ratyimgpath_off,
        scoreName: "post[good]",
        score: json.good
    };
    raty(elem, option);

    if(json.imagepath){
      const imageController = this.application.getControllerForElementAndIdentifier(
      this.element.querySelector('[data-controller="images"]'),
        "images"
      );

      if(imageController){
        imageController.previewImage(json.imagepath)
      }
    }

    const selectController = this.application.getControllerForElementAndIdentifier(
      this.element.querySelector('[data-controller="selectmenu"]'),
      "selectmenu"
    );

    if(selectController){
      json.prefectures.forEach( item =>{
        selectController.createBadge(item.prefecture)
      })
    }

    const tagController = this.application.getControllerForElementAndIdentifier(
      this.element.querySelector('[data-controller="tag"]'),
      "tag"
    );
    if(tagController){
      console.log(json.tags)
      json.tags.forEach( item =>{
        tagController.addTagHTML(item.tag)
      })
    }
  }

}

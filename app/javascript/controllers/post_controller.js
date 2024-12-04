import { Controller } from "@hotwired/stimulus"

// ブートストラップ ローダ
(g=>{var h,a,k,p="The Google Maps JavaScript API",c="google",l="importLibrary",q="__ib__",m=document,b=window;b=b[c]||(b[c]={});var d=b.maps||(b.maps={}),r=new Set,e=new URLSearchParams,u=()=>h||(h=new Promise(async(f,n)=>{await (a=m.createElement("script"));e.set("libraries",[...r]+"");for(k in g)e.set(k.replace(/[A-Z]/g,t=>"_"+t[0].toLowerCase()),g[k]);e.set("callback",c+".maps."+q);a.src=`https://maps.${c}apis.com/maps/api/js?`+e;d[q]=f;a.onerror=()=>h=n(Error(p+" could not load."));a.nonce=m.querySelector("script[nonce]")?.nonce||"";m.head.append(a)}));d[l]?console.warn(p+" only loads once. Ignoring:",g):d[l]=(f,...n)=>r.add(f)&&u().then(()=>d[l](f,...n))})({
  key: process.env.Maps_API_Key
});

// Connects to data-controller="post"
export default class extends Controller {
  connect() {
    const element = document.getElementById('post_map')
    if(element){
      this.initMap()
      this.map = null
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

    items.places.forEach( place =>{
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
              <img src="${place.image}" class="rounded mx-auto d-block" style="width: 200px; height: auto;">
            </div>
            <label><訪問地名></label>
            <h1 class="h4 font-weight-bold">${place.place_name}</h1>
            <label><感想やメモ> </label>
            <p class="lead">${comment}</p>
            <div class="good">
              <label>おすすめ度</label>
              <label class="text-right" id="star_place_show_${place.id}" data-star-on="${items.ratyimgpath_on}" data-star-off="${items.ratyimgpath_off}">
              </label>
            </div>
            <p class="text-muted">${place.address}</p>
          </div>
        `;

        console.log(place.good)

        const infowindow = new google.maps.InfoWindow({
          content: contentString,
          ariaLabel: "aaaa",
        });

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
    e.preventDefault()
    const formData = new FormData(this.formTarget)

    if(!this.validateForm()){
      this.submitTarget.blur()
      return
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
    }

    if(selectController){

      const selects = selectController.getSelects()

      if(selects.length < 1){
        alert("旅行した都道府県を最低1つ選択してください")
        this.submitTarget.blur()
        return
      }

      selects.forEach((prefecture) => {
        console.log(prefecture)
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

    const actionURL = this.formTarget.action.endsWith('.json') ? this.formTarget.action : this.formTarget.action + '.json';

    //PostモデルのPOSTを行う
    fetch(actionURL, {
      method: "POST",
      body: formData,
      headers: {
        "X-CSRF-Token": document.querySelector("[name='csrf-token']").content
      }
      }).then((response) => {
      if (!response.ok) {
        this.submitTarget.blur()
        return response.text(); // レスポンスのテキストを取得
      }
      console.log("投稿成功");
      return response.json(); // 正常の場合はJSONレスポンスを処理
    })
    .then((data) => {
      if (data && data.error) {
        alert("投稿に失敗しました: " + data.error);
        this.submitTarget.blur()
        return
      }

      if(data.redirect_url){
        window.location.href = data.redirect_url;
      }else{
        alert("リダイレクトURLが含まれていません");
        this.submitTarget.blur()
        return
      }
    })
    .catch((error) => {
      alert("投稿に失敗しました");
      this.submitTarget.blur()
      return
    });

  }

   validateForm(){

    let errormsg = ""
    let isSuccess = true

    const title = this.formTarget.querySelector('[name="post[title]"]');
    const body = this.formTarget.querySelector('[name="post[body]"]');


    // タイトルと投稿内容が空でないかチェック
    if(!title.value.trim()){
      errormsg = errormsg + "タイトルが空欄です\n"
      isSuccess = isSuccess && false
    }

    if (!body.value.trim()) {
      errormsg = errormsg + "投稿内容が空欄です\n"
      isSuccess = isSuccess && false
    }

    if(isSuccess){
      return true
    } else {
      alert(errormsg)
    }
  }

  moveMaker(e){

    const lat = e.target.dataset.latitude
    const lng = e.target.dataset.longitude

    console.log(lat)
    console.log(lng)
    this.map.panTo(new google.maps.LatLng(parseFloat(lat),parseFloat(lng)))
  }

}

import { Controller } from "@hotwired/stimulus"
import { validPlaceForm } from "../packs/validation";
import  toastr from 'toastr';

(g=>{var h,a,k,p="The Google Maps JavaScript API",c="google",l="importLibrary",q="__ib__",m=document,b=window;b=b[c]||(b[c]={});var d=b.maps||(b.maps={}),r=new Set,e=new URLSearchParams,u=()=>h||(h=new Promise(async(f,n)=>{await (a=m.createElement("script"));e.set("libraries",[...r]+"");for(k in g)e.set(k.replace(/[A-Z]/g,t=>"_"+t[0].toLowerCase()),g[k]);e.set("callback",c+".maps."+q);a.src=`https://maps.${c}apis.com/maps/api/js?`+e;d[q]=f;a.onerror=()=>h=n(Error(p+" could not load."));a.nonce=m.querySelector("script[nonce]")?.nonce||"";m.head.append(a)}));d[l]?console.warn(p+" only loads once. Ignoring:",g):d[l]=(f,...n)=>r.add(f)&&u().then(()=>d[l](f,...n))})({
  key: process.env.Maps_API_Key
});

// Connects to data-controller="place"
export default class extends Controller {
  connect() {
    this.tabdatas = []
    this.map = null
    this.isPatch = false
    this.marker = null

    this.initMap().then(() => {
      this.fetchData()
    }).catch((error) => {
      console.error("Map initialization failed:", error);
    });


     this.state = new Proxy(
      {
        currentindex: 0,
      },
      {
        set: (target, property, newValue) => {
          if (property === "currentindex") {
            this.onCurrentIndexChanged(newValue, target[property]); // 値変更時の処理
          }
          target[property] = newValue;
          return true;
        },
      }
    );
  }

  static targets = ["submit", "form", "tabsave", "input", "list", "tab", "modalselect", "deletedata"]

  preventEnterInSearch() {
    this.inputTarget.addEventListener("keydown", (event) => {
      if (event.key === "Enter") {
        event.preventDefault(); // デフォルトのフォーム送信を防ぐ
      }
    });
  }


  async initMap() {
    const { Map } = await google.maps.importLibrary("maps");
    const {AdvancedMarkerElement} = await google.maps.importLibrary("marker") // 追記
    const { PlacesService } = await google.maps.importLibrary("places");
    const lists = document.getElementById('lists');


    const travelSiteTypes = [
      "amusement_park",      // 遊園地
      "aquarium",            // 水族館
      "art_gallery",         // 美術館
      "bakery",              // ベーカリー
      "bar",                 // バー
      "cafe",                // カフェ
      "campground",          // キャンプ場
      "casino",              // カジノ
      "museum",              // 博物館
      "night_club",          // ナイトクラブ
      "park",                // 公園
      "restaurant",          // レストラン
      "shopping_mall",       // ショッピングモール
      "spa",                 // スパ
      "tourist_attraction",  // 観光名所
      "zoo",                 // 動物園
      "lodging",             // 宿泊施設
      "natural_feature",     // 自然の特徴的な場所（湖、山など）
      "train_station",       // 鉄道駅
      "subway_station",      // 地下鉄駅
      "bus_station",         // バス停
      "airport",             // 空港
    ];


  // 追記
    let element = document.getElementById('place_map');
    let center = new google.maps.LatLng(35.6811673, 139.7670516);

    this.map = new Map(element, {
      center: center,
      zoom: 5,
      apiKey: process.env.Place_API_Key,
      disableDefaultUI: true,
    });

    const service = new PlacesService(this.map);
    this.map.addListener('click', (e) => {
      const request = {
        location: e.latLng,
        radius: 100,
      };

    service.nearbySearch(request, (results, status) => {
      lists.innerHTML = ""
      results.forEach(place => {
        const ret = travelSiteTypes.filter(item => place.types.includes(item));
        if(ret.length > 0){
          const placeDetailsRequest = { placeId: place.place_id };
          service.getDetails(placeDetailsRequest, (details, status) => {
            const button = document.createElement("button");
            button.classList.add("list-group-item", "list-group-item-action");
            button.id = "placename";
            button.setAttribute("data-place-target", "modalselect");
            button.setAttribute("data-dismiss", "modal");
            button.setAttribute("data-action", "click->place#setPlaceData");
            button.setAttribute("data-lat", place.geometry.location.lat());
            button.setAttribute("data-lng", place.geometry.location.lng());
            button.textContent = details.name;
            lists.appendChild(button);
          })
        }
      })
    })
    window.$('#mapModal').modal('show');
    })
  }


  saveData(e){
    e.preventDefault()
    const placenameElem = document.getElementById("resultplacename")
    const placename = placenameElem.textContent.trim()

    if(!validPlaceForm(placename)){
      this.submitTarget.blur()
      return
    }

    const comment  = document.getElementById("comment").value;

    const lat = placenameElem.dataset.lat;
    const lng = placenameElem.dataset.lng;


    const parentraty = document.querySelector('#star_place_edit')
    const inputraty = parentraty.querySelector('input')

    const imageController = this.application.getControllerForElementAndIdentifier(
      this.element.querySelector('[data-controller="images"]'),
      "images"
    );

    let image = null
    if(imageController){
      image = imageController.getImage()
    }

    let placenum = this.tabdatas.length + 1
    if(this.tabdatas[this.state.currentindex]){
      placenum = this.state.currentindex + 1
    }

    let raty = inputraty.value
    if(!raty.trim()){
      raty = 0
    }

    const tabdata = {
      place_name: placename,
      comment: comment,
      latitude: lat,
      longitude: lng,
      image: image,
      good: raty,
      place_num: this.state.currentindex + 1
    }

    console.log(tabdata)

    //既存データの更新か確認する
    if(this.tabdatas[this.state.currentindex]){
      this.tabdatas[this.state.currentindex] = tabdata
      document.querySelectorAll('.placedata').item(this.state.currentindex).textContent = (this.state.currentindex + 1) + ":" + placename

    }else{
      //保存
      this.tabdatas.push(tabdata)
      //タブのところに訪問地名設定
      document.querySelectorAll('.placedata').item(this.tabdatas.length - 1).textContent = (this.tabdatas.length) + ":" + placename

    }

    this.visibleDeleteBtn(true)
    this.changesaveTabButtonText(true)
    toastr.success("訪問地を保存しました。")

  }


  submitForm(e){
    e.preventDefault()
    const tabdatas = this.tabdatas

    if(!confirm("投稿を確定しますか？内容は投稿詳細ページより編集可能です")){
      return
    }

    const formData = new FormData();

    tabdatas.forEach( ( data, index )=>{

      formData.append(`place[${index}][place_name]`, data.place_name)
      formData.append(`place[${index}][comment]`, data.comment)
      formData.append(`place[${index}][latitude]`, data.latitude)
      formData.append(`place[${index}][longitude]`, data.longitude)
      if(data.image){
        formData.append(`place[${index}][image]`, data.image)
      }
      formData.append(`place[${index}][good]`, data.good)
      formData.append(`place[${index}][place_num]`, data.place_num)
      if(data.id){
        formData.append(`place[${index}][id]`, data.id)
      }else{
        formData.append(`place[${index}][id]`, null)
      }

    })

    const actionURL = this.formTarget.action.endsWith('.json') ? this.formTarget.action : this.formTarget.action + '.json';
    const isEdit = window.location.pathname.includes("/edit");
    const requestMethod = isEdit ? "PATCH" : "POST";

    //PostモデルのPOSTを行う
    fetch(actionURL, {
      method: requestMethod,
      body: formData, // 配列をそのまま送信
      headers: {
        'X-CSRF-Token': document.querySelector("[name='csrf-token']").content
      }
      }).then((response) => {
        return response.json(); // 正常の場合はJSONレスポンスを処理
    })
    .then((data) => {
      if(data && data.redirect_url){
        //トースト通知のメッセージをストレージに格納し、リダイレクト後にトースト通知を行う
        localStorage.setItem('toastMessage', JSON.stringify({
          type: 'success',
          message: data.message
        }));
        window.location.href = data.redirect_url;
      }else{
        console.log("called")
        toastr.error(data.message);
        this.submitTarget.blur()
        return
      }
    })
    .catch((error) => {
      if(error.message){
        toastr.error(error.message)
      }else{
        toastr.error("不明なエラーが発生しました。時間を置いて再度お試しください。また解決しない場合は問題が解決しない場合は、サポートまでご連絡ください。")
      }
      console.error("キャッチされたエラー:", error.message);
      this.submitTarget.blur()
      return
    });

  }

  addTabs(e){

    const placedataindex = document.querySelectorAll('.placedata').length

    if(!this.tabdatas[placedataindex - 1]){
      toastr.error("現在の観光地情報が保存されていないため、タブを追加出来ません。")
      return
    }
    const newNavItem = document.createElement("li");
    newNavItem.classList.add('nav-item', 'm-0');

    const newButton = document.createElement('button');
    newButton.classList.add('nav-link', 'border','border-secondary', 'placedata', 'bg-primary', 'text-white');
    newButton.textContent = placedataindex + 1
    newButton.setAttribute("data-place-target", "tab")
    newButton.setAttribute("data-action","click->place#loadPlacedata")

    newNavItem.appendChild(newButton);

    e.target.parentNode.parentNode.insertBefore(newNavItem, e.target.parentNode);
  }

  resetForm(){
    const comment = document.getElementById("comment")
    const placename = document.getElementById("resultplacename");

    //現在のフォームをクリアする
    placename.textContent = ""
    this.inputTarget.value = ""
    comment.value = ""

    //マーカーリセット
    this.removeMarker()

    //評価数リセット
    this.resetRaty()

    const imageController = this.application.getControllerForElementAndIdentifier(
      this.element.querySelector('[data-controller="images"]'),
      "images"
    );

    if(imageController){
      imageController.visibleImage(false);
    }

    this.visibleDeleteBtn(false)
  }

  resetRaty(){
    var selectname = '#star_place_edit'
    var elem = document.querySelector(selectname);
    elem.innerHTML = ""
    var option = {
        starOn: elem.dataset.starOn,
        starOff: elem.dataset.starOff,
        scoreName: "place[good]",
        score: 0
    };
    raty(elem, option);
  }

  loadraty( good ){

    var selectname = '#star_place_edit'
    var elem = document.querySelector(selectname);
    elem.innerHTML = ""
    var option = {
        starOn: elem.dataset.starOn,
        starOff: elem.dataset.starOff,
        scoreName: "place[good]",
        score: good
    };
    raty(elem, option);
  }


  loadPlacedata(e){
    const child = Array.from(document.querySelectorAll(".placedata"))
    const index = child.indexOf(e.target)

    const placedata = this.tabdatas[index]
    this.resetForm()
    console.log(placedata)

    //データが保存されている場合
    if(placedata){

      this.addPlaceNameAndMaker(placedata.latitude,placedata.longitude, placedata.place_name)
      this.showFormData(placedata.comment, placedata.good, placedata.image, placedata.place_name)
      this.changesaveTabButtonText(true)
      this.visibleDeleteBtn(true)

    }else{
      this.changesaveTabButtonText(false)
      this.visibleDeleteBtn(false)
    }

    this.updateCurrentIndex(index)
  }

  addPlaceNameAndMaker(lat, lng, placeName){
    const placename = document.getElementById('resultplacename');

    placename.textContent = placeName
    placename.dataset.lat = lat
    placename.dataset.lng = lng
    this.addMarker(lat, lng, placeName)

  }

  removeMarker(){

    if(this.marker){
      this.marker.setMap(null)
      this.marker = null
    }
  }

  addMarker(lat, lng, placename){

    this.removeMarker()
  console.log("lat:", lat)
  console.log("lng:", lng)
  console.log("placename:", placename)
   const marker = new google.maps.Marker ({
      position: { lat: parseFloat(lat), lng: parseFloat(lng) },
      map: this.map,
      title: "test",
    });

    this.marker = marker;

    this.map.panTo(new google.maps.LatLng(parseFloat(lat),parseFloat(lng)))

    const contentString = `
          <div class="information container p-0">
            <div class="mb-3 d-flex align-items-center">
              <p class="lead m-0 font-weight-bold">${placename}</p>
            </div>
          </div>
        `;

        const infowindow = new google.maps.InfoWindow({
          content: contentString,
          ariaLabel: placename,
        });

        infowindow.open({ anchor: marker, map: this.map})

  }

  async showSuggest(e){
    if (e.key === "Enter" && e.target.type !== "submit") {
        e.preventDefault();

      const placename = document.getElementById('resultplacename');
      const request = {
        textQuery:e.target.value,
        fields: ["displayName","location"],
        maxResultCount: 7,

      };

      const lists = document.getElementById("searchlists")

      const { Place } =  await google.maps.importLibrary("places");
      const { places } = await Place.searchByText(request);

      if(places.length > 0){
        lists.innerHTML = ""
        places.forEach((place) => {

          const dynamicContent = `<button type="button" class="list-group-item list-group-item-action border" id="placename" data-place-target="list" data-action="click->place#setPlaceData" `+ "data-lat=" + place.location.lat() + ` `+ "data-lng=" + place.location.lng() + ">"  +　`<i class="fa-solid fa-location-dot pr-3"></i>` + place.displayName + "</button >";
          lists.innerHTML = lists.innerHTML + dynamicContent

        })
      }
    }
  }

  setPlaceData(e){
    window.$('#mapModal').modal('hide');
    e.currentTarget.parentElement.innerHTML = ""
    this.addPlaceNameAndMaker(e.target.dataset.lat, e.target.dataset.lng, e.target.textContent)
  }


  changesaveTabButtonText(isOldData){
    console.log("changesaveTabButtonText")
    console.log("isOldData:", isOldData)
    const savebtn = document.getElementById('savetabbutton');

    if(isOldData){
      savebtn.textContent = "個別訪問地を更新"
    }else{
      savebtn.textContent = "個別訪問地を登録"
    }

  }

  async fetchData(){

    const currentPath = window.location.pathname;
    let element = document.getElementById('place_map');
    const targetURL = `/posts/${element.dataset.id}/places/edit`


    if (targetURL != currentPath) {
      console.log("観光地編集以外のページのためfetchしません")
      return
    }

    const actionURL = `/posts/${element.dataset.id}/places/edit.json`
    const response = await fetch(actionURL);
    if (!response.ok) throw new Error('Network response was not ok');
    const json = await response.json();

    this.loadJSONData(json.data)

  }

  loadJSONData(json){
    const sortedPlaces = json.places.sort((a, b) => a.place_num - b.place_num);

    console.log(json.places)
    json.places.forEach((place, index)=>{

      const tabdata = {
        place_name: place.place_name,
        comment: place.comment,
        latitude: place.latitude,
        longitude: place.longitude,
        image: place.image,
        good: place.good,
        place_num: place.place_num,
        id: place.id
      }

      console.log(place.image)

      this.tabdatas[index] = tabdata

      if(index > 0){
        this.addTabsHTML(index)
        document.querySelectorAll('.placedata').item(index).textContent = index + 1 + ":" + place.place_name
      }else{
        document.querySelectorAll('.placedata').item(index).textContent = index + 1 + ":" + place.place_name
      }

    })
    this.addPlaceNameAndMaker(this.tabdatas[0].latitude,this.tabdatas[0].longitude,this.tabdatas[0].place_name)
    this.showFormData(this.tabdatas[0].comment, this.tabdatas[0].good, this.tabdatas[0].image, this.tabdatas[0].place_name)
    this.visibleDeleteBtn(true)
    this.changesaveTabButtonText(true)


  }

  addTabsHTML(index){

    if(!this.tabdatas[index]){
      alert("現在の観光地情報が保存されていないため、タブを追加出来ません")
      return
    }
    const newNavItem = document.createElement("li");
    newNavItem.classList.add('nav-item', 'm-0');

    const newButton = document.createElement('button');
    newButton.classList.add('nav-link', 'border', 'border-secondary','placedata','bg-primary', 'text-white');
    newButton.textContent = index
    newButton.setAttribute("data-place-target", "tab")
    newButton.setAttribute("data-action","click->place#loadPlacedata")

    newNavItem.appendChild(newButton);

    const parentPlacedata = document.querySelectorAll('.placedata').item(index - 1).parentNode;
    const parentparentPlacedata = parentPlacedata.parentNode;

    parentPlacedata.appendChild(newNavItem)
  }

  removePlaceData(e){
    e.preventDefault()

    this.resetForm()

    //データの削除
    this.tabdatas.splice(this.state.currentindex, 1)

    //place_numを再度採番する
    this.tabdatas.forEach((data, index)=>{
      data.place_num = index + 1
    })

    //追加ボタン以外のPlaceタブを削除する
    let placeTabs = document.querySelectorAll('.placedata')
    if(placeTabs.length > 1){
      placeTabs[this.state.currentindex].remove()
      console.log(placeTabs)
      placeTabs = document.querySelectorAll('.placedata')
      placeTabs.forEach((tab, index) =>{
        console.log("index:", index)
        if(this.tabdatas[index]){
          tab.textContent = this.tabdatas[index].place_num + ":" + this.tabdatas[index].place_name
        }else{
          tab.textContent = index + 1
        }
      })

      if(this.state.currentindex == this.tabdatas.length){
        this.updateCurrentIndex(this.state.currentindex - 1)
      }

      console.log(this.tabdatas)

      this.showFormData(this.tabdatas[this.state.currentindex].comment, this.tabdatas[this.state.currentindex].good, this.tabdatas[this.state.currentindex].image, this.tabdatas[this.state.currentindex].place_name)
      this.addMarker(this.tabdatas[this.state.currentindex].latitude, this.tabdatas[this.state.currentindex].longitude, this.tabdatas[this.state.currentindex].place_name)
      this.changesaveTabButtonText(true)
      this.visibleDeleteBtn(true)
      this.onCurrentIndexChanged(this.state.currentindex, null)
    }else{
      placeTabs[0].textContent = "1"
      this.changesaveTabButtonText(false)
    }

  }

  showFormData( comment, good, image, place_name ){
     //フォームにも表示させるようにする
    const commentElement = document.getElementById("comment")
    commentElement.value = comment
    this.loadraty(good)

    const imageController = this.application.getControllerForElementAndIdentifier(
    this.element.querySelector('[data-controller="images"]'),
      "images"
    );


    if(image){
      if(imageController){
        imageController.previewImage(image)
      }
    }

    const placeElement = document.getElementById("resultplacename")
    placeElement.textContent = place_name
  }

  visibleDeleteBtn(isShow){
    const btn = document.getElementById("deletebtn")

    if(isShow){
      btn.style.display = "block"
    }else{
      btn.style.display = "none"
    }
  }

  updateCurrentIndex(newIndex){
    this.state.currentindex = newIndex
  }

  onCurrentIndexChanged(newValue, oldValue){
    const parentPlacedata = document.querySelectorAll('.placedata')

    if(newValue == oldValue){
      parentPlacedata[newValue].classList.remove("bg-primary")
      parentPlacedata[newValue].classList.add("bg-danger")
      return
    }

    //選択されているタブは赤くする
    parentPlacedata[newValue].classList.remove("bg-primary")
    parentPlacedata[newValue].classList.add("bg-danger")

    //選択されていたタブは青に戻す

    if(parentPlacedata[oldValue]){
      parentPlacedata[oldValue].classList.remove("bg-danger")
      parentPlacedata[oldValue].classList.add("bg-primary")
    }


    console.log(newValue)
    console.log(oldValue)

  }

}

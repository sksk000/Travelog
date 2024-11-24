// ブートストラップ ローダ
(g=>{var h,a,k,p="The Google Maps JavaScript API",c="google",l="importLibrary",q="__ib__",m=document,b=window;b=b[c]||(b[c]={});var d=b.maps||(b.maps={}),r=new Set,e=new URLSearchParams,u=()=>h||(h=new Promise(async(f,n)=>{await (a=m.createElement("script"));e.set("libraries",[...r]+"");for(k in g)e.set(k.replace(/[A-Z]/g,t=>"_"+t[0].toLowerCase()),g[k]);e.set("callback",c+".maps."+q);a.src=`https://maps.${c}apis.com/maps/api/js?`+e;d[q]=f;a.onerror=()=>h=n(Error(p+" could not load."));a.nonce=m.querySelector("script[nonce]")?.nonce||"";m.head.append(a)}));d[l]?console.warn(p+" only loads once. Ignoring:",g):d[l]=(f,...n)=>r.add(f)&&u().then(()=>d[l](f,...n))})({
  key: process.env.Maps_API_Key
});

let map;
let markers = [];

const tabdatas = {
  locations:[]
}

async function initMap() {
  const { Map } = await google.maps.importLibrary("maps");
  const {AdvancedMarkerElement} = await google.maps.importLibrary("marker") // 追記
  const { PlacesService } = await google.maps.importLibrary("places");
  const lists = document.getElementById('lists');
  const placename = document.getElementById('resultplacename');

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
  const response = await fetch(`/posts/${element.dataset.id}/places/new.json`);
  if (!response.ok) throw new Error('Network response was not ok');

  let center = new google.maps.LatLng(35.6811673, 139.7670516);

  map = new Map(element, {
    center: center,
    zoom: 15,
    apiKey: process.env.Place_API_Key,
    disableDefaultUI: true,
  });

  const service = new PlacesService(map);
  map.addListener('click', (e) => {
    //const marker = new google.maps.Marker ({
    //    position: e.latLng,
    //    map,
    //    title: "test",
    //  });

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
          const dynamicContent = `
            <button class="list-group-item list-group-item-action" id="placename" data-dismiss="modal"`+ "data-lat=" + place.geometry.location.lat() + ` ` + "data-lng=" + place.geometry.location.lng() + ">"  + details.name + "</button >";
            lists.innerHTML = lists.innerHTML + dynamicContent
          })

          lists.addEventListener('click', function(e){
            placename.textContent = "訪問地：" + e.target.textContent
            addMarker(e.target.dataset.lat, e.target.dataset.lng, e.target.textContent)
          })
        }
      })
    })

  window.$('#mapModal').modal('show');
  });



  let searchlist = document.getElementById("searchinput");
  searchlist.addEventListener("keydown",showSuggest);

  const registerbtn = document.getElementById("register");
  registerbtn.addEventListener('click', saveTabData);


}

initMap();


async function showSuggest(e){
  if (e.key === "Enter" && e.target.type !== "submit") {
      e.preventDefault();
    const placename = document.getElementById('resultplacename');
    const request = {
      textQuery:e.target.value,
      fields: ["displayName","location"],
      isOpenNow: true,
      maxResultCount: 7,

    };
    const lists = document.getElementById("searchlists")

    const { Place } =  await google.maps.importLibrary("places");
    const { places } = await Place.searchByText(request);

    if(places.length > 0){
      lists.innerHTML = ""
      places.forEach((place) => {

        const dynamicContent = `
            <button class="list-group-item list-group-item-action" id="placename" data-dismiss="modal"`+ "data-lat=" + place.location.lat() + ` ` + "data-lng=" + place.location.lng() + ">"  + place.displayName + "</button >";
              lists.innerHTML = lists.innerHTML + dynamicContent

        lists.addEventListener('click', function(e){
          e.preventDefault();
          placename.textContent = "訪問地：" + e.target.textContent
          placename.dataset.lat = place.location.lat()
          placename.dataset.lng = place.location.lng()

          lists.innerHTML = ""
          addMarker(e.target.dataset.lat, e.target.dataset.lng, place.displayName)

        })
      })

    } else {
      console.log("No results");
    }
  }
}


function addMarker(lat, lng, placename){

  removeMarkers()

 const marker = new google.maps.Marker ({
    position: { lat: parseFloat(lat), lng: parseFloat(lng) },
    map,
    title: "test",
  });

  markers.push(marker);

  map.panTo(new google.maps.LatLng(parseFloat(lat),parseFloat(lng)))

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

      infowindow.open({
          anchor: marker,
          map,
        })

}

function removeMarkers(){
  for (const marker of markers){
    marker.setMap(null)
  }

  markers = []
}


function saveTabData(){

  console.log("called")

  const placenameElem = document.getElementById("resultplacename")
  const placename = placenameElem.textContent


  const comment  = document.getElementById("comment").value;

  const image = document.querySelector("preview-area");

  if(image){
    image.files[0]
  }

  const lat = placenameElem.dataset.lat;
  const lng = placenameElem.dataset.lng;

  const tabdata = {
    name: placename,
    comment: comment,
    location: { lat: lat, lng: lng},
    image: image,
    rating: 1,
  }


  //保存
  tabdatas.locations.push(tabdata)

}

function addTabs(){

}

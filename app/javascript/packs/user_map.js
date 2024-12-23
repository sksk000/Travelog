// ブートストラップ ローダ
(g=>{var h,a,k,p="The Google Maps JavaScript API",c="google",l="importLibrary",q="__ib__",m=document,b=window;b=b[c]||(b[c]={});var d=b.maps||(b.maps={}),r=new Set,e=new URLSearchParams,u=()=>h||(h=new Promise(async(f,n)=>{await (a=m.createElement("script"));e.set("libraries",[...r]+"");for(k in g)e.set(k.replace(/[A-Z]/g,t=>"_"+t[0].toLowerCase()),g[k]);e.set("callback",c+".maps."+q);a.src=`https://maps.${c}apis.com/maps/api/js?`+e;d[q]=f;a.onerror=()=>h=n(Error(p+" could not load."));a.nonce=m.querySelector("script[nonce]")?.nonce||"";m.head.append(a)}));d[l]?console.warn(p+" only loads once. Ignoring:",g):d[l]=(f,...n)=>r.add(f)&&u().then(()=>d[l](f,...n))})({
  key: process.env.Maps_API_Key
});

async function initMap() {
  const { Map } = await google.maps.importLibrary("maps");
  const {AdvancedMarkerElement} = await google.maps.importLibrary("marker") // 追記


  // 追記
  let element = document.getElementById('user_map');

  const response = await fetch(`/mypage/${element.dataset.id}/place.json`);
  if (!response.ok) throw new Error('Network response was not ok');

  const { data: { items } } = await response.json();

  var target_latitude;
  var target_longitude;

  for(var data of items.places){
    for(var place of data){
      if(place.latitude && place.longitude ){
        target_latitude = place.latitude;
        target_longitude = place.longitude;
        break;
      }
    }
  }

  map = new Map(document.getElementById("user_map"), {
    center: { lat: target_latitude, lng: target_longitude },
    zoom: 5,
    mapId: process.env.Maps_API_Key, // 追記    mapTypeControl: false
  });

 for(let data of items.places){
    for(let place of data){

      const latitude = place.latitude;
      const longitude = place.longitude;
      const comment  = place.comment;

      if(latitude == null && longitude == null) continue;

      const marker = new google.maps.marker.AdvancedMarkerElement ({
        position: { lat: latitude, lng: longitude },
        map,
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
            map,
          })


            setTimeout(() => {
              console.log(place.id)
            const elem = document.querySelector(`#star_place_show_${place.id}`);
            console.log(elem)
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
    }
  }
}

initMap();

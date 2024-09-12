// ブートストラップ ローダ
(g=>{var h,a,k,p="The Google Maps JavaScript API",c="google",l="importLibrary",q="__ib__",m=document,b=window;b=b[c]||(b[c]={});var d=b.maps||(b.maps={}),r=new Set,e=new URLSearchParams,u=()=>h||(h=new Promise(async(f,n)=>{await (a=m.createElement("script"));e.set("libraries",[...r]+"");for(k in g)e.set(k.replace(/[A-Z]/g,t=>"_"+t[0].toLowerCase()),g[k]);e.set("callback",c+".maps."+q);a.src=`https://maps.${c}apis.com/maps/api/js?`+e;d[q]=f;a.onerror=()=>h=n(Error(p+" could not load."));a.nonce=m.querySelector("script[nonce]")?.nonce||"";m.head.append(a)}));d[l]?console.warn(p+" only loads once. Ignoring:",g):d[l]=(f,...n)=>r.add(f)&&u().then(()=>d[l](f,...n))})({
  key: process.env.Maps_API_Key
});

async function initMap() {
  const { Map } = await google.maps.importLibrary("maps");
  const {AdvancedMarkerElement} = await google.maps.importLibrary("marker") // 追記


  // 追記
  let element = document.getElementById('post_map');
  console.log('dataset', element.dataset.id);
  let place_id = location.search;
  console.log('url', place_id)

  const response = await fetch(`/posts/${element.dataset.id}.json${place_id}`);
  if (!response.ok) throw new Error('Network response was not ok');

  const { data: { items } } = await response.json();

  const target_latitude = items.latitude;
  const target_longitude = items.longitude;

  console.log('Latitude:', target_latitude);
  console.log('Longitude:', target_longitude);


  map = new Map(document.getElementById("post_map"), {
    center: { lat: target_latitude, lng: target_longitude },
    zoom: 15,
    mapId: "DEMO_MAP_ID", // 追記    mapTypeControl: false
  });

  console.log(items.places);

  items.places.forEach( place =>{
    const latitude = place.latitude;
    const longitude = place.longitude;
    const comment  = place.comment;

    const marker = new google.maps.marker.AdvancedMarkerElement ({
      position: { lat: latitude, lng: longitude },
      map,
      title: comment,
    });

    console.log(place);
    console.log(comment);
    // 追記
      const contentString = `
        <div class="information container p-0">
          <div>
            <h1 class="h4 font-weight-bold">${place.place_name}</h1>
            <p class="text-muted">${place.address}</p>
            <p class="lead">${comment}</p>
          </div>
        </div>
      `;

      const infowindow = new google.maps.InfoWindow({
        content: contentString,
        ariaLabel: "aaaa",
      });

      marker.addListener("click", () => {
          infowindow.open({
          anchor: marker,
          map,
        })
      });
  });

}

initMap();

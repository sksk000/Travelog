// ブートストラップ ローダ
(g=>{var h,a,k,p="The Google Maps JavaScript API",c="google",l="importLibrary",q="__ib__",m=document,b=window;b=b[c]||(b[c]={});var d=b.maps||(b.maps={}),r=new Set,e=new URLSearchParams,u=()=>h||(h=new Promise(async(f,n)=>{await (a=m.createElement("script"));e.set("libraries",[...r]+"");for(k in g)e.set(k.replace(/[A-Z]/g,t=>"_"+t[0].toLowerCase()),g[k]);e.set("callback",c+".maps."+q);a.src=`https://maps.${c}apis.com/maps/api/js?`+e;d[q]=f;a.onerror=()=>h=n(Error(p+" could not load."));a.nonce=m.querySelector("script[nonce]")?.nonce||"";m.head.append(a)}));d[l]?console.warn(p+" only loads once. Ignoring:",g):d[l]=(f,...n)=>r.add(f)&&u().then(()=>d[l](f,...n))})({
  key: process.env.Maps_API_Key
});

async function initMap() {
  const { Map } = await google.maps.importLibrary("maps");
  const {AdvancedMarkerElement} = await google.maps.importLibrary("marker") // 追記


  // 追記
  let element = document.getElementById('place_map');
  const response = await fetch(`/posts/${element.dataset.id}/places/new.json`);
  if (!response.ok) throw new Error('Network response was not ok');

  //const { data: { items } } = await response.json();

  //const target_latitude = items.latitude;
  //const target_longitude = items.longitude;

  map = new Map(element, {
    center: { lat: 35.665498, lng: 139.75964 },
    zoom: 15,
    mapId: process.env.Maps_API_Key,
    disableDefaultUI: true,// 追記    mapTypeControl: false
  });


}

initMap();

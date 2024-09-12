var timer = 3000;

// すべての画像を取得
var imgs = document.querySelectorAll("#slider img");

//一番最初の画像を表示する
imgs[0].classList.add('show');
var num = 0;

function showImg () {
  //表示していた画像を非表示にする
  imgs[num].classList.remove('show');

  //次の画像番号を設定
  if (num >= imgs.length - 1) {
    num = 0;
  } else {
    num++;
  }

  //表示設定
  imgs[num].classList.add('show');
  showImgTimer();
}
function showImgTimer () {
  setTimeout(showImg, timer);
}


showImgTimer();
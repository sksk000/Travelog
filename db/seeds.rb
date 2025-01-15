# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


icchan = User.find_or_create_by!(email: "icchan@example.com") do |user|
  user.name = "いっちゃん"
  user.password = "a|3xh/9ZMV#v"
  user.introduction = "旅行好きの主婦のいっちゃんです！夫との旅行を記録していきたいと思います。おいしい食べ物が好きで、特に肉や寿司が大好きです！"
  user.profile_image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'onepiece01_luffy.png')), filename: 'onepiece01_luffy.png')
end
jiro = User.find_or_create_by!(email: "jiro@example.com") do |user|
  user.name = "食べ過ぎ二郎"
  user.password = "y%/FZv+p8a`R"
  user.profile_image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'onepiece03_nami.png')), filename: 'onepiece03_nami.png')
  user.introduction = "食べ過ぎ二郎です！ラーメンが好き！大盛りであればあるほどうれしい！"
end
sun = User.find_or_create_by!(email: "sun@example.com") do |user|
  user.name = "サンサン"
  user.password = "j7!t%SbT96_D"
  user.profile_image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'onepiece02_zoro.png')), filename: 'onepiece02_zoro.png')
  user.introduction = "エンジニアとして働いています。長期間の旅行が好きで、寒い地域を好みます。カメラで綺麗な風景を取るのが趣味。"
end
yonsama = User.find_or_create_by!(email: "yonsama@example.com") do |user|
  user.name = "よん様"
  user.password = "C/_o.%Z?*A9z"
  user.profile_image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'onepiece06_chopper.png')), filename: 'onepiece06_chopper.png')
  user.introduction = "韓流ドラマとヨン様好き～ 西日本に良く旅行に行きます！おすすめの居酒屋があれば教えて欲しい！"
end

Admin.find_or_create_by!(email: "admin@example.com") do |admin|
  admin.password = "x.w/VX2>eABN"
end

ActiveRecord::Base.transaction do
  posts_data = {
    sun_hokkaido: {
      user: icchan,
      title: "北海道3泊旅！新鮮な魚介と夜景を楽しむ女子4人旅！",
      body: "クリスマスシーズンに女子4人で北海道に3泊しました！プリプリで新鮮な魚に舌鼓！また行きたい！",
      good: 4,
      night: 3,
      people: 4,
      travelmonth: 12,
      image: "seedsimages/sapporo_hirosaki.jpg",
      places: [
        { name: "五稜郭跡", latitude: 41.79758107418, longitude: 140.75661498610842, comment: "有名な五稜郭！歴史感じました～。", image: "seedsimages/hokkaido_goryokaku.jpg", good: 5 },
        { name: "回転寿司 函館 旬花", latitude: 41.7951025578, longitude: 140.753760449372, comment: "寿司！大ぶりなネタが超新鮮で美味しい！", image: "seedsimages/sushi.jpg", good: 5 },
        { name: "プレミアホテル-TSUBAKI-札幌", latitude: 43.05462147667883, longitude: 141.3657015268982, comment: "過不足ないホテルでした！ベッドふかふかで最高！", image: "seedsimages/bed.jpg", good: 4 },
        { name: "十勝大橋", latitude: 42.93960227483929, longitude: 143.2014107442466, comment: "凄く大きい橋でした！景色も良いです～", image: "seedsimages/bridge.jpg", good: 4 },
        { name: "ふらのワイン工場 富良野市ぶどう果樹研究所", latitude: 43.374693279518375, longitude: 142.3793629771605, comment: "大好きなワインを出来立てで試飲！美味しすぎた！", image: "seedsimages/wine.jpg", good: 5 }
      ],
      tags: ["自然", "歴史", "魚介"],
      prefectures: [0],
      comments: [
        { user: "食べ過ぎ二郎", text: "北海道出身なので懐かしい気持ちになりました！是非ウニも食べてみて！" },
        { user: "サンサン", text: "ワインいいですね。自分も行ってみたいです！" }
      ]
    },
    jiro_tokyo: {
      user: icchan,
      title: "ラーメン二郎巡ってみた",
      body: "大好きなラーメン二郎を1泊2日で巡ってみました。胃袋に自身はあったのですが合計3店舗しか行けなかった。。また時間作って二郎巡りしたいな～",
      good: 5,
      night: ,
      people: 4,
      travelmonth: 12,
      image: "seedsimages/sapporo_hirosaki.jpg",
      places: [
        { name: "ラーメン二郎 三田本店", latitude: 35.648225621704078, longitude: 139.74164332559033, comment: "初めて三田本店にいきました、次も控えているためコールなしで注文！チャーシューがほろほろで染みた野菜が美味しすぎる・・。麺は少し柔めで太さもあり食べ応えがある！最高でした。。", image: "seedsimages/hokkaido_goryokaku.jpg", good: 5 },
        { name: "ラーメン二郎 神田神保町店", latitude: 35.69527613138069, longitude: 139.7609022274397, comment: "こちらも初めての訪問、あの「レベルの高い合格点を超える二郎 オールウェイズ出してくれる」でおなじみの場所。食べ切れるか分からないので麺少なめに。三田本店より量多き氣がするのはきのせい？けど美味しかった～～！", image: "seedsimages/sushi.jpg", good: 5 },
        { name: "アパホテル(神田神保町駅東)", latitude: 35.69470617799219, longitude: 139.76230085385862, comment: "ラーメン二郎の近くだったのでココに決めました、普通によかった。", image: "seedsimages/sushi.jpg", good: 3 },
        { name: "ラーメン二郎 亀戸店", latitude: 35.70291804775031, longitude: 139.82615013237017, comment: "何回か訪問した亀戸二郎、チャーシュー最高すぎ・・。醤油のキレがよくて麺とよくあって美味しい。今度は選択肢として汁なしも検討しよう。", image: "seedsimages/sushi.jpg", good: 5 },
      ],
      tags: ["二郎"],
      prefectures: [0],
      comments: [
        { user: "いっちゃん", text: "そんなに食べたの！？すごーい！！！前、夫といっしょに二郎系行ったとき1杯で動けないぐらいお腹いっぱいだった。。" },
      ]
    },
  }

  posts_data.each do |user_key, post_data|
    user = post_data[:user]
    post = Post.find_or_create_by!(user: user, title: post_data[:title]) do |p|
      p.body = post_data[:body]
      p.good = post_data[:good]
      p.night = post_data[:night]
      p.people = post_data[:people]
      p.travelmonth = post_data[:travelmonth]
      p.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', post_data[:image])), filename: post_data[:image])
    end

    post_data[:places].each_with_index do |place_data, index|
      Place.find_or_create_by!(post: post, place_name: place_data[:name]) do |place|
        place.latitude = place_data[:latitude]
        place.longitude = place_data[:longitude]
        place.comment = place_data[:comment]
        place.place_num = index + 1
        place.good = place_data[:good]
        place.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', place_data[:image])), filename: place_data[:image])
      end
    end

    post_data[:tags].each do |tag_name|
      tag = Tag.find_or_create_by!(name: tag_name)
      PostTag.find_or_create_by!(post: post, tag: tag)
    end

    post_data[:prefectures].each do |prefecture|
      PostPrefecture.find_or_create_by!(post_id: post.id, prefecture: prefecture)
    end

    post_data[:comments].each do |comment_data|
      comment_user = User.find_by(name: comment_data[:user])
      post.comments.create!(user: comment_user, comment: comment_data[:text])
    end
  end
end

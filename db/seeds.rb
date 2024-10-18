# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


judy = User.find_or_create_by!(email: "judy@example.com") do |user|
  user.name = "Judy"
  user.password = "password"
  user.profile_image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'onepiece01_luffy.png')), filename: 'onepiece01_luffy.png')
end
lucas = User.find_or_create_by!(email: "lucas@example.com") do |user|
  user.name = "Lucas"
  user.password = "password"
  user.profile_image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'onepiece02_zoro.png')), filename: 'onepiece02_zoro.png')
end
olivia = User.find_or_create_by!(email: "olivia@example.com") do |user|
  user.name = "Olivia"
  user.password = "password"
  user.profile_image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'onepiece03_nami.png')), filename: 'onepiece03_nami.png')
end


Admin.find_or_create_by!(email: "example@example.com") do |admin|
  admin.password = "password"
end


# Judyの投稿データ
judy_post_first = Post.find_or_initialize_by(user: judy, title: "1日で京都の名所を巡りました！") do |post_data|
  post_data.body = "京都の観光地を一日で回りました。清水寺は歴史的な雰囲気が素晴らしく、金閣寺の庭園も見事でした。嵐山竹林の小径は自然の中でリラックスできました。"
  post_data.good = 2
  post_data.season = 1
  post_data.place = 1
  post_data.night = 2
  post_data.people = 3
  post_data.is_release = true
  post_data.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'ash-edmonds-uztw2giebSc-unsplash.jpg')), filename: 'ash-edmonds-uztw2giebSc-unsplash.jpg')
  post_data.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'david-emrich-EJvGBYjrwEA-unsplash.jpg')), filename: 'david-emrich-EJvGBYjrwEA-unsplash.jpg')
  post_data.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'sorasak-_UIN-pFfJ7c-unsplash.jpg')), filename: 'sorasak-_UIN-pFfJ7c-unsplash.jpg')
end

# Placeデータ
Place.create(post: judy_post_first, place_name: "清水寺", address: "京都府京都市東山区清水1丁目294", comment:"歴史の重みを感じる美しい寺院。観光客が多いですが、それでも落ち着ける雰囲気です。", place_num: 1)
Place.create(post: judy_post_first, place_name: "国際通り", address: "沖縄県那覇市牧志", comment:"素敵", place_num: 2)
Place.create(post: judy_post_first, place_name: "金閣寺", address: "京都府京都市北区金閣寺町1", comment: "庭園の美しさが印象的でした。", place_num: 3)
Place.create(post: judy_post_first, place_name: "嵐山竹林の小径", address: "京都府京都市右京区嵐山", comment: "自然の中でリラックスできるスポット。", place_num: 4)

judy_post_second = Post.find_or_initialize_by(user: judy, title: "京都へ行った") do |post_data|
  post_data.body = "私は久々に京都へ行きました。"
  post_data.good = 2
  post_data.season = 1
  post_data.place = 1
  post_data.night = 2
  post_data.people = 3
  post_data.is_release = true
  post_data.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'ash-edmonds-uztw2giebSc-unsplash.jpg')), filename: 'ash-edmonds-uztw2giebSc-unsplash.jpg')
  post_data.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'david-emrich-EJvGBYjrwEA-unsplash.jpg')), filename: 'david-emrich-EJvGBYjrwEA-unsplash.jpg')
  post_data.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'sorasak-_UIN-pFfJ7c-unsplash.jpg')), filename: 'sorasak-_UIN-pFfJ7c-unsplash.jpg')
end

# Placeデータ
Place.create(post: judy_post_second, place_name: "祇園", address: "京都府京都市東山区祇園町", comment: "古い町並みが残る素敵な場所。", place_num: 1)
Place.create(post: judy_post_second, place_name: "伏見稲荷大社", address: "京都府京都市伏見区深草薮之内町68", comment: "千本鳥居が美しく、圧巻でした。", place_num: 2)
Place.create(post: judy_post_second, place_name: "平安神宮", address: "京都府京都市左京区岡崎最勝寺町", comment: "大きな鳥居が印象的な神社。", place_num: 3)
Place.create(post: judy_post_second, place_name: "南禅寺", address: "京都府京都市左京区南禅寺福地町", comment: "静かな場所で心が落ち着きました。", place_num: 4)

judy_post_third = Post.find_or_initialize_by(user: judy, title: "秋の紅葉を楽しむ") do |post_data|
  post_data.body = "紅葉が美しい季節に、嵐山へ行きました。特に渡月橋からの景色は最高でした。"
  post_data.good = 4
  post_data.season = 2
  post_data.place = 1
  post_data.night = 1
  post_data.people = 2
  post_data.is_release = true
  post_data.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'jason-rost-LjRiVC6UOLw-unsplash.jpg')), filename: 'jason-rost-LjRiVC6UOLw-unsplash.jpg')
  post_data.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'diana-lisunova-6aUxu7-RgiI-unsplash.jpg')), filename: 'diana-lisunova-6aUxu7-RgiI-unsplash.jpg')
  post_data.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'jason-rost-LjRiVC6UOLw-unsplash.jpg')), filename: 'jason-rost-LjRiVC6UOLw-unsplash.jpg')
end

# Placeデータ
Place.create(post: judy_post_third, place_name: "嵐山", address: "京都府京都市右京区嵐山", comment: "秋の色とりどりの景色が素晴らしかったです。", place_num: 1)
Place.create(post: judy_post_third, place_name: "天龍寺", address: "京都府京都市右京区嵐山天龍寺", comment: "歴史を感じる美しい庭園。静かな時間を過ごせました。", place_num: 2)
Place.create(post: judy_post_third, place_name: "哲学の道", address: "京都府京都市左京区", comment: "穏やかな散策路で心が癒されました。", place_num: 3)
Place.create(post: judy_post_third, place_name: "北野天満宮", address: "京都府京都市上京区馬喰町", comment: "紅葉が美しい神社でした。", place_num: 4)



# Oliviaの投稿データ
olivia_post_first = Post.find_or_initialize_by(user: olivia, title: "東京観光の思い出") do |post_data|
  post_data.body = "友達と一緒に東京観光を楽しみました。東京タワーからの景色は最高でした。"
  post_data.good = 4
  post_data.season = 1
  post_data.place = 1
  post_data.night = 1
  post_data.people = 2
  post_data.is_release = true
  post_data.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'charles-postiaux-q_xbE7RSvBI-unsplash.jpg')), filename: 'charles-postiaux-q_xbE7RSvBI-unsplash.jpg')
  post_data.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'clay-banks-hwLAI5lRhdM-unsplash.jpg')), filename: 'clay-banks-hwLAI5lRhdM-unsplash.jpg')
  post_data.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'jezael-melgoza-layMbSJ3YOE-unsplash.jpg')), filename: 'jezael-melgoza-layMbSJ3YOE-unsplash.jpg')
end

# Placeデータ
Place.create(post: olivia_post_first, place_name: "東京タワー", address: "東京都港区芝公園4-2-8", comment: "夜景がとても美しかったです。", place_num: 1)
Place.create(post: olivia_post_first, place_name: "浅草寺", address: "東京都台東区浅草2-3-1", comment: "歴史的な建物が素晴らしい。", place_num: 2)
Place.create(post: olivia_post_first, place_name: "上野恩賜公園", address: "東京都台東区上野公園", comment: "広い公園で、散歩が気持ちよかったです。", place_num: 3)
Place.create(post: olivia_post_first, place_name: "新宿御苑", address: "東京都新宿区内藤町11", comment: "春の桜が美しかったです。", place_num: 4)

olivia_post_second = Post.find_or_initialize_by(user: olivia, title: "秋のハイキング") do |post_data|
  post_data.body = "紅葉を見ながらハイキングを楽しみました。自然の中でリフレッシュできました。"
  post_data.good = 5
  post_data.season = 2
  post_data.place = 1
  post_data.night = 1
  post_data.people = 3
  post_data.is_release = true
  post_data.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'nitish-meena-RbbdzZBKRDY-unsplash.jpg')), filename: 'nitish-meena-RbbdzZBKRDY-unsplash.jpg')
  post_data.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'artem-sapegin-8c6eS43iq1o-unsplash.jpg')), filename: 'artem-sapegin-8c6eS43iq1o-unsplash.jpg')
  post_data.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'mark-basarab-z8ct_Q3oCqM-unsplash.jpg')), filename: 'mark-basarab-z8ct_Q3oCqM-unsplash.jpg')
end

# Placeデータ
Place.create(post: olivia_post_second, place_name: "高尾山", address: "東京都八王子市高尾町", comment: "登山道が整備されていて登りやすいです。", place_num: 1)
Place.create(post: olivia_post_second, place_name: "奥多摩", address: "東京都西多摩郡奥多摩町", comment: "美しい自然に囲まれて癒されました。", place_num: 2)
Place.create(post: olivia_post_second, place_name: "秩父", address: "埼玉県秩父市", comment: "紅葉が美しく、見ごたえがありました。", place_num: 3)
Place.create(post: olivia_post_second, place_name: "富士山", address: "山梨県甲府市", comment: "登山は疲れましたが、最高の景色でした。", place_num: 4)

olivia_post_third = Post.find_or_initialize_by(user: olivia, title: "沖縄旅行の楽しい思い出") do |post_data|
  post_data.body = "美しいビーチでリラックスできました。海の透明度が素晴らしかったです。"
  post_data.good = 4
  post_data.season = 1
  post_data.place = 0
  post_data.night = 3
  post_data.people = 4
  post_data.is_release = true
  post_data.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'sho-k-et0v7wY9meI-unsplash.jpg')), filename: 'sho-k-et0v7wY9meI-unsplash.jpg')
  post_data.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'krisna-yuda-REX9d0MBzas-unsplash.jpg')), filename: 'krisna-yuda-REX9d0MBzas-unsplash.jpg')
  post_data.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'bigfoot-stngr-vAIQhqzLiFk-unsplash.jpg')), filename: 'bigfoot-stngr-vAIQhqzLiFk-unsplash.jpg')
end

# Placeデータ
Place.create(post: olivia_post_third, place_name: "美ら海水族館", address: "沖縄県国頭郡本部町石川424", comment: "海の生物がたくさんいて楽しかったです。", place_num: 1)
Place.create(post: olivia_post_third, place_name: "万座毛", address: "沖縄県恩納村", comment: "夕日が綺麗でした。", place_num: 2)
Place.create(post: olivia_post_third, place_name: "古宇利島", address: "沖縄県名護市", comment: "美しいビーチでのんびり過ごせました。", place_num: 3)
Place.create(post: olivia_post_third, place_name: "首里城", address: "沖縄県那覇市首里金城町1丁目2", comment: "歴史を感じる場所でした。", place_num: 4)



# Lucasの投稿データ
lucas_post_first = Post.find_or_initialize_by(user: lucas, title: "北海道の自然を満喫") do |post_data|
  post_data.body = "大自然の中で過ごし、心が洗われる体験をしました。"
  post_data.good = 5
  post_data.season = 0
  post_data.place = 1
  post_data.night = 4
  post_data.people = 2
  post_data.is_release = true
  post_data.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'catriona-palo-z3vZramK67A-unsplash.jpg')), filename: 'catriona-palo-z3vZramK67A-unsplash.jpg')
  post_data.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'nopparuj-lamaikul-xeHZlrNCuy8-unsplash.jpg')), filename: 'nopparuj-lamaikul-xeHZlrNCuy8-unsplash.jpg')
  post_data.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'ian-lai-mNkV0Ni5aJg-unsplash.jpg')), filename: 'ian-lai-mNkV0Ni5aJg-unsplash.jpg')
end

# Placeデータ
Place.create(post: lucas_post_first, place_name: "大雪山", address: "北海道上川地方", comment: "壮大な自然が楽しめる場所です。", place_num: 1)
Place.create(post: lucas_post_first, place_name: "美瑛の青い池", address: "北海道美瑛町", comment: "美しい青色の池が感動的でした。", place_num: 2)
Place.create(post: lucas_post_first, place_name: "富良野", address: "北海道富良野市", comment: "ラベンダー畑が素晴らしかったです。", place_num: 3)
Place.create(post: lucas_post_first, place_name: "函館山", address: "北海道函館市", comment: "夜景が最高でした。", place_num: 4)

lucas_post_second = Post.find_or_initialize_by(user: lucas, title: "沖縄のビーチでリラックス") do |post_data|
  post_data.body = "美しい海で過ごす時間は最高でした。"
  post_data.good = 4
  post_data.season = 1
  post_data.place = 0
  post_data.night = 2
  post_data.people = 3
  post_data.is_release = true
  post_data.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'krisna-yuda-REX9d0MBzas-unsplash.jpg')), filename: 'krisna-yuda-REX9d0MBzas-unsplash.jpg')
  post_data.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'sho-k-et0v7wY9meI-unsplash.jpg')), filename: 'sho-k-et0v7wY9meI-unsplash.jpg')
  post_data.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'bigfoot-stngr-vAIQhqzLiFk-unsplash.jpg')), filename: 'bigfoot-stngr-vAIQhqzLiFk-unsplash.jpg')
end

# Placeデータ
Place.create(post: lucas_post_second, place_name: "恩納村ビーチ", address: "沖縄県恩納村", comment: "透明な海でシュノーケリングが楽しかった。", place_num: 1)
Place.create(post: lucas_post_second, place_name: "国際通り", address: "沖縄県那覇市牧志", comment: "賑やかな雰囲気で楽しかった。", place_num: 2)
Place.create(post: lucas_post_second, place_name: "万座毛", address: "沖縄県恩納村", comment: "絶景スポットでした。", place_num: 3)
Place.create(post: lucas_post_second, place_name: "美ら海水族館", address: "沖縄県国頭郡本部町", comment: "海の生き物たちが見られて楽しかった。", place_num: 4)

lucas_post_third = Post.find_or_initialize_by(user: lucas, title: "東京の新しい体験") do |post_data|
  post_data.body = "新しいカフェやスポットを訪れました。"
  post_data.good = 3
  post_data.season = 1
  post_data.place = 1
  post_data.night = 1
  post_data.people = 2
  post_data.is_release = true
  post_data.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'nathan-dumlao-Y3AqmbmtLQI-unsplash.jpg')), filename: 'knathan-dumlao-Y3AqmbmtLQI-unsplash.jpg')
  post_data.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'petr-sevcovic-qE1jxYXiwOA-unsplash.jpg')), filename: 'petr-sevcovic-qE1jxYXiwOA-unsplash.jpg')
  post_data.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'roman-bozhko-OXXsAafHDeo-unsplash.jpg')), filename: 'roman-bozhko-OXXsAafHDeo-unsplash.jpg')
end

# Placeデータ
Place.create(post: lucas_post_third, place_name: "原宿", address: "東京都渋谷区神宮前", comment: "トレンドを感じる場所でした。", place_num: 1)
Place.create(post: lucas_post_third, place_name: "秋葉原", address: "東京都千代田区外神田", comment: "オタク文化を満喫できました。", place_num: 2)
Place.create(post: lucas_post_third, place_name: "浅草", address: "東京都台東区浅草", comment: "歴史を感じられる場所です。", place_num: 3)
Place.create(post: lucas_post_third, place_name: "六本木ヒルズ", address: "東京都港区六本木6丁目10-1", comment: "夜景が美しかった。", place_num: 4)

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
  user.introduction = "こんにちは！私はJudyです。旅行と美味しい食べ物が大好きで、特に日本の文化に魅了されています。最近は京都に行きました。歴史的な場所や美しい自然を楽しみながら、新しい経験をするのが私の喜びです。"
  user.profile_image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'onepiece01_luffy.png')), filename: 'onepiece01_luffy.png')
end
lucas = User.find_or_create_by!(email: "lucas@example.com") do |user|
  user.name = "Lucas"
  user.password = "password"
  user.profile_image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'onepiece02_zoro.png')), filename: 'onepiece02_zoro.png')
  user.introduction = "はじめまして、Lucasです。技術とゲームが好きなエンジニア志望です。プログラミングや新しい技術を学ぶのが楽しく、将来は自分のプロジェクトを持ちたいと思っています。自由な時間には、友達とアウトドアを楽しんでいます。"
end
olivia = User.find_or_create_by!(email: "olivia@example.com") do |user|
  user.name = "Olivia"
  user.password = "password"
  user.profile_image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'onepiece03_nami.png')), filename: 'onepiece03_nami.png')
  user.introduction = "こんにちは、Oliviaです！アートや音楽に興味があり、クリエイティブなことが好きです。最近は自分の絵を描いたり、地元の音楽イベントに参加したりしています。友達と過ごす時間が何よりの宝物です。"
end


Admin.find_or_create_by!(email: "example@example.com") do |admin|
  admin.password = "password"
end


# Judyの投稿データ
judy_post_first = Post.find_or_initialize_by(user: judy, title: "1日で京都の名所を巡りました！") do |post_data|
  post_data.body = "京都の観光地を一日で回りました。まず、清水寺を訪れました。歴史的な雰囲気が素晴らしく、その美しい景観は、どこを見ても感動を覚えます。特に、清水の舞台から見下ろす町並みは息を呑むほど美しかったです。その後、金閣寺に向かい、その庭園の見事さに圧倒されました。金閣寺の金色の外観は、周囲の景色と見事に調和しており、特に水面に映る姿は幻想的でした。また、庭園を散策しながら、様々な植物や花の美しさを楽しむことができました。次に、嵐山竹林の小径を歩きました。竹が生い茂る道は、静寂に包まれ、まるで別世界にいるような気分にさせてくれます。風に揺れる竹の音が心地よく、リラックスできる場所でした。その後、嵐山で有名な渡月橋を渡り、美しい景色を楽しみました。ここからは、川の流れや山々の風景が広がり、心が癒されました。さらに、地元の名物である抹茶アイスを食べながら、優雅なひとときを過ごしました。最後に、京都の伝統的な町並みを散策し、古いお店や工芸品を見ながら、地元の人々との交流も楽しみました。京都の魅力を存分に感じる一日でした。"
  post_data.good = 2
  post_data.night = 2
  post_data.people = 3
  post_data.prefecture = 3
  post_data.travelmonth = 4
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

Comment.create(post: judy_post_first, user: olivia, comment: "すごく楽しそう！", good: 3)
Comment.create(post: judy_post_first, user: lucas, comment: "次に行く時はぜひ一緒に！", good: 2)
Comment.create(post: judy_post_first, user: judy, comment: "行ってみたい場所です！", good: 5)
Comment.create(post: judy_post_first, user: olivia, comment: "京都はやっぱり最高ですね。", good: 1)

judy_post_second = Post.find_or_initialize_by(user: judy, title: "京都へ行った") do |post_data|
  post_data.body = "私は久々に京都へ行きました。"
  post_data.good = 0
  post_data.night = 2
  post_data.people = 3
  post_data.prefecture = 20
  post_data.travelmonth = 1
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

Comment.create(post: judy_post_second, user: olivia, comment: "京都旅行の定番ですね！", good: 3)
Comment.create(post: judy_post_second, user: lucas, comment: "次は一緒に行きたい！", good: 4)
Comment.create(post: judy_post_second, user: judy, comment: "素敵な体験でした。", good: 5)
Comment.create(post: judy_post_second, user: olivia, comment: "楽しかった！", good: 2)

judy_post_third = Post.find_or_initialize_by(user: judy, title: "秋の紅葉を楽しむ") do |post_data|
  post_data.body = "紅葉が美しい季節に、嵐山へ行きました。特に渡月橋からの景色は最高でした。"
  post_data.good = 4
  post_data.night = 1
  post_data.people = 2
  post_data.prefecture = 10
  post_data.travelmonth = 10
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

Comment.create(post: judy_post_third, user: olivia, comment: "嵐山の紅葉、本当に綺麗ですよね。渡月橋からの景色が特に好きです！", good: 4)
Comment.create(post: judy_post_third, user: lucas, comment: "紅葉シーズンの京都は最高ですね！私も行きたくなりました。", good: 3)
Comment.create(post: judy_post_third, user: olivia, comment: "天龍寺も行きましたが、庭園が美しくて感動しました。", good: 5)
Comment.create(post: judy_post_third, user: judy, comment: "嵐山、また訪れたいです！", good: 2)


=begin
# Oliviaの投稿データ
olivia_post_first = Post.find_or_initialize_by(user: olivia, title: "東京観光の思い出") do |post_data|
  post_data.body = "友達と一緒に東京観光を楽しみました。東京タワーからの景色は最高でした。"
  post_data.good = 3
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

Comment.create(post: olivia_post_first, user: lucas, comment: "東京タワーからの景色、絶景ですね！夜景は特におすすめ。", good: 5)
Comment.create(post: olivia_post_first, user: judy, comment: "東京観光は本当に楽しいですよね。スカイツリーもいいですよ！", good: 3)
Comment.create(post: olivia_post_first, user: olivia, comment: "友達と行った東京観光、思い出深いです。次は浅草にも行ってみたいです。", good: 4)
Comment.create(post: olivia_post_first, user: judy, comment: "東京の名所巡り、楽しそうですね。おすすめのカフェも知りたいです。", good: 2)




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

Comment.create(post: olivia_post_second, user: judy, comment: "紅葉を見ながらのハイキング、素敵ですね！", good: 4)
Comment.create(post: olivia_post_second, user: lucas, comment: "高尾山はいいですよね、自然の中でリフレッシュできそう。", good: 3)
Comment.create(post: olivia_post_second, user: olivia, comment: "奥多摩もおすすめですよ！", good: 5)
Comment.create(post: olivia_post_second, user: judy, comment: "富士山登山、すごい経験ですね！景色が最高そう。", good: 2)



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

Comment.create(post: olivia_post_third, user: judy, comment: "沖縄は美しい場所ですよね！ビーチが特に好きです。", good: 4)
Comment.create(post: olivia_post_third, user: lucas, comment: "万座毛の夕日は素晴らしかったと聞きます。", good: 3)
Comment.create(post: olivia_post_third, user: olivia, comment: "首里城、また行きたいな！", good: 5)
Comment.create(post: olivia_post_third, user: judy, comment: "美ら海水族館は一度行ってみたいです。", good: 2)



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

Comment.create(post: lucas_post_first, user: judy, comment: "スキー最高ですね！", good: 3)
Comment.create(post: lucas_post_first, user: lucas, comment: "また一緒に行こう！", good: 4)
Comment.create(post: lucas_post_first, user: olivia, comment: "スキー日和でした！", good: 5)
Comment.create(post: lucas_post_first, user: judy, comment: "行きたくなりました！", good: 2)

lucas_post_second = Post.find_or_initialize_by(user: lucas, title: "沖縄のビーチでリラックス") do |post_data|
  post_data.body = "美しい海で過ごす時間は最高でした。"
  post_data.good = 2
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

Comment.create(post: lucas_post_second, user: olivia, comment: "沖縄、最高！", good: 4)
Comment.create(post: lucas_post_second, user: judy, comment: "美しい海！", good: 5)
Comment.create(post: lucas_post_second, user: lucas, comment: "また行きたい！", good: 3)
Comment.create(post: lucas_post_second, user: judy, comment: "次は一緒に行こう！", good: 2)

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

Comment.create(post: lucas_post_third, user: judy, comment: "東京の新しいスポット、楽しそう！", good: 3)
Comment.create(post: lucas_post_third, user: olivia, comment: "原宿と秋葉原は特に興味があります！", good: 4)
Comment.create(post: lucas_post_third, user: lucas, comment: "カフェ巡りが特に良かった。", good: 5)
Comment.create(post: lucas_post_third, user: olivia, comment: "夜景が美しかったって聞いて行きたい！", good: 2)

lucas_post_third = Post.find_or_initialize_by(user: lucas, title: "ヨーロッパでの新しい体験") do |post_data|
  post_data.body = "今回のヨーロッパ旅行は、人生の中でも特に忘れられない経験となりました。まず、フランスのパリでは、エッフェル塔やルーブル美術館、モンマルトルの丘を訪れました。パリは、その歴史と文化の深さが、どこに行っても感じられる街でした。特に美術館で見た名画や、エッフェル塔からの夜景が印象に残っています。また、地元のカフェで楽しんだクロワッサンやコーヒーもとても美味しかったです。次に訪れたイタリアのベニスは、全く異なる雰囲気でした。運河が街を囲み、ゴンドラでの移動は初めての経験でした。ゴンドラから見る夕日は、本当に美しく、言葉では表せないほど感動しました。また、ベニスの街並み自体も、歴史を感じさせる建物や石畳が広がっており、どこを歩いても写真に収めたくなるような景色ばかりでした。スペインのバルセロナでは、ガウディの作品を目の当たりにすることができました。サグラダ・ファミリアは特に圧巻で、その壮大な建築はまさに芸術そのものでした。また、地元のレストランでいただいたパエリアは、これまでに食べたことのないほど美味しく、食文化も大いに堪能しました。バルセロナの街並みも、近代的な建物と歴史的な建物が混在しており、非常に活気がありました。そして最後に訪れたイギリスのロンドンは、世界的に有名な観光地がたくさんある街で、ビッグベンやロンドン塔、バッキンガム宮殿を訪れました。ロンドンの街は、歴史的な雰囲気がありながらも、現代的な要素も持ち合わせており、その独特な融合が非常に興味深かったです。特に、テムズ川沿いを歩きながら、ロンドンアイや橋の景色を楽しむことができ、心が癒されました。"
  post_data.good = 1
  post_data.season = 1
  post_data.place = 0
  post_data.night = 3
  post_data.people = 4
  post_data.is_release = true
  post_data.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'krisna-yuda-REX9d0MBzas-unsplash.jpg')), filename: 'krisna-yuda-REX9d0MBzas-unsplash.jpg')
  post_data.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'sho-k-et0v7wY9meI-unsplash.jpg')), filename: 'sho-k-et0v7wY9meI-unsplash.jpg')
  post_data.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'bigfoot-stngr-vAIQhqzLiFk-unsplash.jpg')), filename: 'bigfoot-stngr-vAIQhqzLiFk-unsplash.jpg')
end

# Placeデータ
Place.create(post: lucas_post_third, place_name: "パリ", address: "フランス、パリ", comment: "美術館とエッフェル塔が印象的でした。", place_num: 1)
Place.create(post: lucas_post_third, place_name: "ベニス", address: "イタリア、ベニス", comment: "ゴンドラに乗って、水路を巡りました。", place_num: 2)
Place.create(post: lucas_post_third, place_name: "バルセロナ", address: "スペイン、バルセロナ", comment: "サグラダ・ファミリアは圧巻でした。", place_num: 3)
Place.create(post: lucas_post_third, place_name: "ロンドン", address: "イギリス、ロンドン", comment: "歴史的な建物が多く、街を散策しました。", place_num: 4)

# コメントデータ
Comment.create(post: lucas_post_third, user: judy, comment: "パリとベニス、どちらも素敵な場所だね！", good: 3)
Comment.create(post: lucas_post_third, user: olivia, comment: "バルセロナのサグラダ・ファミリア、行ってみたい！", good: 4)
Comment.create(post: lucas_post_third, user: lucas, comment: "どの都市もそれぞれ違った魅力があって楽しかった。", good: 5)
Comment.create(post: lucas_post_third, user: olivia, comment: "ロンドンも素敵！観光名所が多そう。", good: 2)

=end
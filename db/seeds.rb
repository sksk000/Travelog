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

image_files = [
  'artem-sapegin-8c6eS43iq1o-unsplash.jpg',
  'ash-edmonds-uztw2giebSc-unsplash.jpg',
  'bigfoot-stngr-vAIQhqzLiFk-unsplash.jpg',
  'catriona-palo-z3vZramK67A-unsplash.jpg',
  'charles-postiaux-q_xbE7RSvBI-unsplash.jpg',
  'clay-banks-hwLAI5lRhdM-unsplash.jpg',
  'daniils-petrovs-tSSGfx_gsd8-unsplash.jpg',
  'david-emrich-EJvGBYjrwEA-unsplash.jpg',
  'diana-lisunova-6aUxu7-RgiI-unsplash.jpg',
  'ian-lai-mNkV0Ni5aJg-unsplash.jpg',
  'jason-rost-LjRiVC6UOLw-unsplash.jpg',
  'jezael-melgoza-layMbSJ3YOE-unsplash.jpg',
  'krisna-yuda-REX9d0MBzas-unsplash.jpg',
  'mark-basarab-z8ct_Q3oCqM-unsplash.jpg',
  'mojiko_turutama_MKT4588_TP_V.jpg',
  'nathan-dumlao-Y3AqmbmtLQI-unsplash.jpg',
  'nitish-meena-RbbdzZBKRDY-unsplash.jpg'
]




# Judyの投稿データ
judy_post_first = Post.find_or_initialize_by(user: judy, title: "1日で京都の名所を巡りました！") do |post_data|
  post_data.body = "京都の観光地を一日で回りました。まず、清水寺を訪れました。歴史的な雰囲気が素晴らしく、その美しい景観は、どこを見ても感動を覚えます。特に、清水の舞台から見下ろす町並みは息を呑むほど美しかったです。その後、金閣寺に向かい、その庭園の見事さに圧倒されました。金閣寺の金色の外観は、周囲の景色と見事に調和しており、特に水面に映る姿は幻想的でした。また、庭園を散策しながら、様々な植物や花の美しさを楽しむことができました。次に、嵐山竹林の小径を歩きました。竹が生い茂る道は、静寂に包まれ、まるで別世界にいるような気分にさせてくれます。風に揺れる竹の音が心地よく、リラックスできる場所でした。その後、嵐山で有名な渡月橋を渡り、美しい景色を楽しみました。ここからは、川の流れや山々の風景が広がり、心が癒されました。さらに、地元の名物である抹茶アイスを食べながら、優雅なひとときを過ごしました。最後に、京都の伝統的な町並みを散策し、古いお店や工芸品を見ながら、地元の人々との交流も楽しみました。京都の魅力を存分に感じる一日でした。"
  post_data.good = 2
  post_data.night = 2
  post_data.people = 3
  post_data.travelmonth = 4
  post_data.is_release = true
  post_data.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'ash-edmonds-uztw2giebSc-unsplash.jpg')), filename: 'ash-edmonds-uztw2giebSc-unsplash.jpg')
end

# Placeデータ
Place.find_or_create_by(post: judy_post_first, place_name: "清水寺") do |place|
  place.latitude = 35.0038
  place.longitude = 135.7850
  place.comment = "歴史の重みを感じる美しい寺院。"
  place.place_num = 1
  place.good = 2
  place.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', image_files.sample)), filename: image_files.sample)
end
Place.find_or_create_by(post: judy_post_first, place_name: "清水寺") do |place|
  place.latitude = 35.0038
  place.longitude = 135.7850
  place.comment = "歴史の重みを感じる美しい寺院。観光客が多いですが、それでも落ち着ける雰囲気です。"
  place.place_num = 1
  place.good = 2
  place.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', image_files.sample)), filename: image_files.sample)
end
Place.find_or_create_by(post: judy_post_first, place_name: "国際通り") do |place|
  place.latitude = 26.2124
  place.longitude = 127.6792
  place.comment = "素敵"
  place.place_num = 2
  place.good = 1
  place.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', image_files.sample)), filename: image_files.sample)
end
Place.find_or_create_by(post: judy_post_first, place_name: "金閣寺") do |place|
  place.latitude = 35.0394
  place.longitude = 135.7292
  place.comment = "庭園の美しさが印象的でした。"
  place.place_num = 3
  place.good = 4
  place.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', image_files.sample)), filename: image_files.sample)
end
Place.find_or_create_by(post: judy_post_first, place_name: "嵐山竹林の小径") do |place|
  place.latitude = 35.0282
  place.longitude = 135.6760
  place.comment = "自然の中でリラックスできるスポット。"
  place.place_num = 4
  place.good = 4
  place.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', image_files.sample)), filename: image_files.sample)
end

PostPrefecture.find_or_create_by(post: judy_post_first, prefecture: 3)
PostPrefecture.find_or_create_by(post: judy_post_first, prefecture: 6)
PostPrefecture.find_or_create_by(post: judy_post_first, prefecture: 8)
PostPrefecture.find_or_create_by(post: judy_post_first, prefecture: 10)

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


judy = User.find_or_create_by!(email: "judy@example.com") do |user|
  user.name = "山田花子"
  user.password = "a|3xh/9ZMV#v"
  user.introduction = "こんにちは！私は山田花子です。旅行と美味しい食べ物が大好きで、特に日本の文化に魅了されています。最近は京都に行きました。歴史的な場所や美しい自然を楽しみながら、新しい経験をするのが私の喜びです。"
  user.profile_image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'onepiece01_luffy.png')), filename: 'onepiece01_luffy.png')
end
lucas = User.find_or_create_by!(email: "lucas@example.com") do |user|
  user.name = "山田太郎"
  user.password = "password"
  user.profile_image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'onepiece02_zoro.png')), filename: 'onepiece02_zoro.png')
  user.introduction = "はじめまして、山田太郎です。技術とゲームが好きなエンジニア志望です。プログラミングや新しい技術を学ぶのが楽しく、将来は自分のプロジェクトを持ちたいと思っています。自由な時間には、友達とアウトドアを楽しんでいます。"
end
olivia = User.find_or_create_by!(email: "olivia@example.com") do |user|
  user.name = "山田次郎"
  user.password = "password"
  user.profile_image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'onepiece03_nami.png')), filename: 'onepiece03_nami.png')
  user.introduction = "こんにちは、山田次郎です！アートや音楽に興味があり、クリエイティブなことが好きです。最近は自分の絵を描いたり、地元の音楽イベントに参加したりしています。友達と過ごす時間が何よりの宝物です。"
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

tags = ["自然", "歴史", "リラックス", "冒険", "家族旅行", "グルメ", "文化", "絶景", "アクティビティ", "買い物"]

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

tags = ["自然", "歴史", "リラックス", "冒険", "家族旅行", "グルメ", "文化", "絶景", "アクティビティ", "買い物"]

users = {
  judy_hokkaido: User.find_by(name: "Judy"),
  lucas_okinawa: User.find_by(name: "Lucas"),
  olivia_osaka: User.find_by(name: "Olivia")
}

# 地域別の観光地設定
places_coordinates = {
  # 北海道エリア
  judy_hokkaido: [
    { name: "札幌テレビ塔", latitude: 43.0611, longitude: 141.3584 },
    { name: "大通公園", latitude: 43.0600, longitude: 141.3400 },
    { name: "小樽運河", latitude: 43.1894, longitude: 140.9949 }
  ],

  # 京都エリア
  lucas_okinawa: [
    { name: "金閣寺", latitude: 35.0394, longitude: 135.7292 },
    { name: "清水寺", latitude: 35.0328, longitude: 135.7850 },
    { name: "伏見稲荷大社", latitude: 35.0257, longitude: 135.7728 }
  ],

  # 大阪エリア
  olivia_osaka: [
    { name: "大阪城", latitude: 34.6873, longitude: 135.5262 },
    { name: "道頓堀", latitude: 34.6688, longitude: 135.5010 },
    { name: "ユニバーサル・スタジオ・ジャパン", latitude: 34.6687, longitude: 135.4322 }
  ],

  # 沖縄エリア
  lucas_okinawa_2: [
    { name: "首里城", latitude: 26.2125, longitude: 127.6792 },
    { name: "美ら海水族館", latitude: 26.8353, longitude: 127.8788 },
    { name: "国際通り", latitude: 26.2127, longitude: 127.6810 }
  ],

  # 広島エリア
  judy_hokkaido_2: [
    { name: "厳島神社", latitude: 34.2966, longitude: 132.3197 },
    { name: "広島平和記念公園", latitude: 34.3963, longitude: 132.4594 },
    { name: "広島城", latitude: 34.3964, longitude: 132.4597 }
  ],

  # 福岡エリア
  olivia_osaka_2: [
    { name: "福岡タワー", latitude: 33.5903, longitude: 130.3564 },
    { name: "大濠公園", latitude: 33.5932, longitude: 130.3595 },
    { name: "博多駅", latitude: 33.5907, longitude: 130.4017 }
  ],

  # 名古屋エリア
  lucas_okinawa_3: [
    { name: "名古屋城", latitude: 35.1857, longitude: 136.8993 },
    { name: "熱田神宮", latitude: 35.1303, longitude: 136.9070 },
    { name: "大須商店街", latitude: 35.1566, longitude: 136.9064 }
  ]
}

users.each do |user_key, user|
  # ユーザーごとに複数の投稿を作成
  places_coordinates[user_key].each_with_index do |place_data, index|
    post = Post.find_or_initialize_by(user: user, title: "#{user.name}の素敵な旅#{index + 1}") do |post_data|
      post_data.body = "#{user.name}が旅した第#{index + 1}弾の記録です。今回は#{place_data[:name]}を訪れ、素晴らしい体験をしました。"
      post_data.good = rand(3..5)
      post_data.night = Post.nights.keys.sample
      post_data.people = Post.people.keys.sample
      post_data.travelmonth = rand(1..12)
      post_data.season = Post.seasons.keys.sample
      post_data.place = Post.places.keys.sample
      post_data.is_release = true
      post_data.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', image_files.sample)), filename: image_files.sample)
    end
    post.save!

    # 投稿に複数のPlaceを関連付け
    places_coordinates[user_key].each_with_index do |place_data, place_index|
      Place.find_or_create_by(post: post, place_name: place_data[:name]) do |place|
        place.latitude = place_data[:latitude]
        place.longitude = place_data[:longitude]
        place.comment = "#{user.name}が訪れた#{place_data[:name]}は、旅行中で特に印象に残ったスポットの一つです。#{place_data[:name]}は景色が美しく感動しました。"
        place.place_num = place_index + 1
        place.good = rand(3..5)
        place.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', image_files.sample)), filename: image_files.sample)
      end
    end

    # ランダムにタグを追加
    selected_tags = tags.sample(3) # 3つのタグをランダムに選択
    selected_tags.each do |tag_name|
      tag = Tag.find_or_create_by(name: tag_name)
      PostTag.find_or_create_by(post: post, tag: tag)
    end
  end
end

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

tags = ["自然", "歴史", "リラックス", "冒険", "家族旅行", "グルメ", "文化", "絶景", "アクティビティ", "買い物"]

users = { judy: User.find_by(name: "Judy"), lucas: User.find_by(name: "Lucas"), olivia: User.find_by(name: "Olivia") }

users.each do |user_key, user|
  3.times do |i|
    post = Post.find_or_initialize_by(user: user, title: "#{user.name}の素敵な旅#{i + 1}") do |post_data|
      post_data.body = "#{user.name}が旅した第#{i + 1}弾の記録です。今回の旅では、特に印象に残る場所を巡りました。どこも素晴らしい体験ができるスポットばかりでした！"
      post_data.good = rand(1..5)
      post_data.night = Post.nights.keys.sample
      post_data.people = Post.people.keys.sample
      post_data.travelmonth = rand(1..12)
      post_data.season = Post.seasons.keys.sample
      post_data.place = Post.places.keys.sample
      post_data.is_release = true
      post_data.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', image_files.sample)), filename: image_files.sample)
    end
    post.save!

    3.times do |place_index|
      Place.find_or_create_by(post: post, place_name: "#{user.name}のおすすめスポット#{place_index + 1}") do |place|
        place.latitude = rand(24.0..45.0)
        place.longitude = rand(123.0..145.0)
        place.comment = "自然と歴史を感じられる素晴らしい場所でした。特に#{place_index + 1}番目のスポットは印象深かったです。"
        place.place_num = place_index + 1
        place.good = rand(1..5)
        place.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', image_files.sample)), filename: image_files.sample)
      end
    end

    prefectures = (0..46).to_a.sample(3)
    prefectures.each do |prefecture|
      PostPrefecture.find_or_create_by(post: post, prefecture: prefecture)
    end

    # ランダムにタグを追加
    selected_tags = tags.sample(3) # 3つのタグをランダムに選択
    selected_tags.each do |tag_name|
      tag = Tag.find_or_create_by(name: tag_name)
      PostTag.find_or_create_by(post: post, tag: tag)
    end
  end
end


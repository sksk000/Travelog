# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


judy = User.find_or_create_by!(email: "judy@example.com") do |user|
  user.name = "はなちゃん"
  user.password = "a|3xh/9ZMV#v"
  user.introduction = "こんにちは！私ははなちゃんです。旅行と美味しい食べ物が大好きで、特に日本の文化に魅了されています。最近は京都に行きました。歴史的な場所や美しい自然を楽しみながら、新しい経験をするのが私の喜びです。"
  user.profile_image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'onepiece01_luffy.png')), filename: 'onepiece01_luffy.png')
end
lucas = User.find_or_create_by!(email: "lucas@example.com") do |user|
  user.name = "やまだ"
  user.password = "password"
  user.profile_image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'onepiece02_zoro.png')), filename: 'onepiece02_zoro.png')
  user.introduction = "はじめまして、やまだです。技術とゲームが好きなエンジニア志望です。プログラミングや新しい技術を学ぶのが楽しく、将来は自分のプロジェクトを持ちたいと思っています。自由な時間には、友達とアウトドアを楽しんでいます。"
end
olivia = User.find_or_create_by!(email: "olivia@example.com") do |user|
  user.name = "じろー"
  user.password = "password"
  user.profile_image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'onepiece03_nami.png')), filename: 'onepiece03_nami.png')
  user.introduction = "こんにちは、じろーです！アートや音楽に興味があり、クリエイティブなことが好きです。最近は自分の絵を描いたり、地元の音楽イベントに参加したりしています。友達と過ごす時間が何よりの宝物です。"
end
ken = User.find_or_create_by!(email: "Ken@example.com") do |user|
  user.name = "けんけん"
  user.password = "password"
  user.profile_image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'onepiece06_chopper.png')), filename: 'onepiece06_chopper.png')
  user.introduction = "こんにちは、けんけんです！物作りが好きで、日々新しいアイデアに挑戦しています。最近はグラフィックデザインや写真撮影に没頭しており、創作活動を通じて自分を表現する楽しさを再発見しています。自由な時間には仲間とカフェ巡りやアウトドアを楽しんでいます。よろしくお願いします！"
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

users = {
  judy_hokkaido_to_tohoku: User.find_by(name: "はなちゃん"),
  lucas_kanto_to_chubu: User.find_by(name: "やまだ"),
  olivia_kansai_to_chugoku: User.find_by(name: "じろー"),
  lucas_kyushu_to_okinawa: User.find_by(name: "けんけん"),
}

titles = [
  "夢のような場所で過ごした一日",
  "新しい発見が待っていた旅行記",
  "忘れられない景色との出会い",
  "心が温まるひととき",
  "次の冒険の始まり",
  "思わず息を呑んだ絶景スポット",
  "心に残る特別な瞬間",
  "知らなかった魅力を発見！",
  "旅の途中で感じた幸せ",
  "まるで映画のようなひととき"
]

# 投稿本文のパターン
body_comments = {
  # 北海道・東北エリア
  judy_hokkaido_to_tohoku: [
    "札幌の冬の景色は本当に美しく、雪に包まれた街を歩くのは、まるで絵本の中にいるようでした。大沼公園の静かな湖面も心を落ち着けてくれます。",
    "弘前城で春の桜を見ました。見事な景色に圧倒され、歴史を感じながら散策できて、とても貴重な体験でした。",
    "秋田の角館では、古い町並みを歩いていると、まるで時代をさかのぼったような気分になり、歴史を感じながら楽しみました。",
    "福島の大内宿は、江戸時代の雰囲気を味わうことができ、石畳の道と茅葺き屋根の家々に心癒されました。",
    "北海道の札幌テレビ塔から見る夜景は素晴らしく、冬の寒さも忘れてしまうほどの美しい眺めでした。"
  ],

  # 関東・中部エリア
  lucas_kanto_to_chubu: [
    "東京タワーのライトアップが幻想的で、夜景を一望する瞬間はまるで映画のワンシーンのようでした。",
    "富士山を近くで見たとき、その圧倒的な大きさに心を奪われました。特に冬の澄んだ空気の中で見る富士山は最高です。",
    "名古屋城の天守閣からの景色はとても素晴らしく、城下町の歴史を感じながら散策できてとても良い時間を過ごしました。",
    "白川郷の合掌造りの家々は、日本の原風景そのもので、雪景色の中を歩くと、まるで時が止まったような感覚に包まれました。",
    "長野の善光寺は、歴史的な意味も大きく、広い境内を散歩しながら心を落ち着けることができました。"
  ],

  # 関西・中国エリア
  olivia_kansai_to_chugoku: [
    "京都の金閣寺は、金箔で覆われた美しい建物と周囲の景色が本当に壮観でした。季節ごとに表情を変える姿が魅力的です。",
    "清水寺は歴史を感じる場所で、境内から見渡す景色が圧巻です。春の桜や秋の紅葉が特に美しいです。",
    "伏見稲荷大社の千本鳥居は壮大で、その道を歩きながら不思議な感覚に包まれました。",
    "広島の厳島神社は海に浮かぶ鳥居がとても印象的で、歴史的な背景にも思いを馳せながら訪れました。",
    "広島平和記念公園では、平和の大切さを改めて感じ、歴史を学びながら心に残る時間を過ごしました。"
  ],

  # 九州・沖縄エリア
  lucas_kyushu_to_okinawa: [
    "福岡タワーから見る博多湾の眺めがとても美しく、夕暮れ時の景色は心を落ち着けてくれました。",
    "大濠公園で散歩しながら、都会の中で自然を感じることができました。地元の人々のリラックスした雰囲気も良かったです。",
    "博多駅周辺では、賑やかな街並みを歩きながら、地元の美味しい食べ物を堪能しました。",
    "沖縄の美ら海水族館は、色とりどりの海の生き物たちがとても印象的で、海の世界を感じることができました。",
    "首里城は沖縄の歴史を感じる場所で、美しい庭園と建物が魅力的でした。沖縄の文化を知ることができました。"
  ]
}


# 地域別の観光地設定
places_coordinates = {
  # 北海道・東北エリア
  judy_hokkaido_to_tohoku: [
    { name: "札幌テレビ塔", latitude: 43.0611, longitude: 141.3584, comment: "札幌の中心地で見る美しい夜景が印象的でした。広がる街並みと共に雪化粧の冬景色がとても素敵です。" },
    { name: "大沼公園", latitude: 42.0235, longitude: 140.7405, comment: "大沼公園では雪の中を散歩して、自然と触れ合いながら心が癒されました。静かな湖面が心を落ち着けてくれます。" },
    { name: "青森の弘前城", latitude: 40.5953, longitude: 140.4596, comment: "弘前城の美しい桜並木を眺めながら散策。春の訪れを感じると共に、歴史ある城の魅力を堪能しました。" },
    { name: "秋田の角館", latitude: 39.7001, longitude: 140.5451, comment: "角館の古い町並みを歩くと、まるで時代をさかのぼったような気分になり、風情を感じながら楽しみました。" },
    { name: "福島の大内宿", latitude: 37.3223, longitude: 139.7892, comment: "大内宿の風景は江戸時代の雰囲気が残り、石畳の街並みと茅葺き屋根の家々がとても印象的でした。" }
  ],

  # 関東・中部エリア
  lucas_kanto_to_chubu: [
    { name: "東京タワー", latitude: 35.6586, longitude: 139.7454, comment: "東京タワーの夜景は幻想的で、都会の美しい風景を一望できるスポット。ライトアップされたタワーが印象的でした。" },
    { name: "富士山", latitude: 35.3606, longitude: 138.7274, comment: "富士山の雄大な姿に感動。晴れた日には、まるで絵画のように美しい山の景色が広がり、心が洗われました。" },
    { name: "名古屋城", latitude: 35.1857, longitude: 136.8993, comment: "名古屋城の天守閣から見る景色は、名古屋の街を一望できてとても素晴らしかったです。歴史を感じる場所でした。" },
    { name: "白川郷", latitude: 36.1596, longitude: 136.9035, comment: "白川郷の合掌造りの家々が並ぶ景色は圧巻で、歴史的な価値を感じながら、雪の中を歩いていると心が癒されました。" },
    { name: "長野の善光寺", latitude: 36.6514, longitude: 138.1810, comment: "善光寺はその広さに驚きました。日本の歴史と文化が息づく場所で、穏やかな気持ちになれる場所です。" }
  ],

  # 関西・中国エリア
  olivia_kansai_to_chugoku: [
    { name: "大阪城", latitude: 34.6873, longitude: 135.5262, comment: "大阪城の壮大な外観に圧倒され、その歴史に触れることができました。天守閣からの眺めも最高です。" },
    { name: "姫路城", latitude: 34.8394, longitude: 134.6939, comment: "姫路城はその白さが美しく、まるで絵に描いたような素晴らしい城でした。近くに広がる公園でゆっくり過ごしました。" },
    { name: "厳島神社", latitude: 34.2966, longitude: 132.3197, comment: "厳島神社の鳥居が海に浮かぶ光景はとても美しく、神聖な雰囲気が漂っていました。訪れる価値がありました。" },
    { name: "広島の原爆ドーム", latitude: 34.3955, longitude: 132.4536, comment: "原爆ドームを目の前にしたとき、過去の悲劇を感じながら平和の大切さを強く認識しました。" },
    { name: "岡山の後楽園", latitude: 34.6616, longitude: 133.9356, comment: "後楽園は美しい庭園で、四季折々の自然の美しさを感じられる場所です。特に春の桜が見事でした。" }
  ],

  lucas_kyushu_to_okinawa: [
    { name: "福岡タワー", latitude: 33.5955, longitude: 130.3997, comment: "福岡タワーから見る博多湾の眺めがとても美しく、夕暮れ時の景色は心を落ち着けてくれました。" },
    { name: "大濠公園", latitude: 33.5924, longitude: 130.3589, comment: "大濠公園で散歩しながら、都会の中で自然を感じることができました。地元の人々のリラックスした雰囲気も良かったです。" },
    { name: "博多駅", latitude: 33.5902, longitude: 130.4203, comment: "博多駅周辺では、賑やかな街並みを歩きながら、地元の美味しい食べ物を堪能しました。" },
    { name: "美ら海水族館", latitude: 26.6946, longitude: 127.8777, comment: "沖縄の美ら海水族館は、色とりどりの海の生き物たちがとても印象的で、海の世界を感じることができました。" },
    { name: "首里城", latitude: 26.2130, longitude: 127.7189, comment: "首里城は沖縄の歴史を感じる場所で、美しい庭園と建物が魅力的でした。沖縄の文化を知ることができました。" }
  ],
}
comments_sample = [
  "こんな素敵な場所、見たことがありません！本当に心が癒されます。",
  "絶対に行きたくなりました！こんな美しい景色が広がっているなんて感動です。",
  "この景色を見た瞬間、言葉が出ませんでした。心が満たされた気がします。",
  "想像以上の美しさでした！また行きたくなる場所です。",
  "とにかく感動しました！これこそ理想の旅行先ですね。",
  "心が震えました。この場所に行ったら、絶対に何度も訪れたくなるはずです。",
  "素晴らしい景色に包まれて、何時間でもぼーっとしていたい気分です。",
  "本当に夢のような場所ですね。行きたい気持ちが止まりません！",
  "この場所の美しさに、ただただ圧倒されました。何度でも訪れたいです。",
  "素晴らしい！どこを見ても絶景で、感動して涙が出そうになりました。",
  "思わず息を呑んでしまいました。この場所には魔法がかかっているみたいです。",
  "こんなに心を動かされる場所があったなんて！もう一度行きたいです。",
  "こんなに美しい場所があるなんて本当に驚きです。ぜひ行ってみたい！",
  "ここで過ごす時間がどれほど貴重なのか、実感できる場所でした。",
  "その美しさに心が震えました。いつか行ってみたくてたまりません！",
  "どんなに疲れていても、ここに来たらリフレッシュできそうです。",
  "まるで映画のワンシーンのような場所ですね！行くべきリストに追加決定です。",
  "こんな素晴らしい景色を見られるなんて、人生最高の瞬間でした。",
  "想像していたよりも何倍も素晴らしい場所で、また行きたくてたまりません。",
  "この場所の美しさに心が癒されました。何時間でもここにいられる。",
  "写真では伝わらない美しさがあり、現地で見ることができて本当に良かった！",
  "景色だけでなく、空気まで美しい。とても贅沢な時間を過ごせました。",
  "こんなに感動的な場所、人生で一度は訪れなければいけません！",
  "自然の力を感じられる場所でした。訪れるたびに心が洗われるようです。",
  "すごくリラックスできる場所ですね。ここに来ると心が安らぎます。",
  "想像以上の美しさでした！一度来たら、何度でも訪れたくなること間違いなし。",
  "ここに来て、全ての疲れが吹き飛びました。本当に素晴らしい場所です。",
  "この景色を見た瞬間、言葉を失いました。本当に言葉にできない美しさです。",
  "まるで異世界に迷い込んだような感覚を味わいました。素晴らしい！",
  "心から癒される場所です。こんな場所があるなんて、本当に驚きました。",
  "自然の美しさに圧倒される一方、心が落ち着きました。最高の場所です。",
  "これほど素晴らしい場所があったなんて、もっと早く知りたかったです。",
  "想像していた以上の美しさに、ただただ感動するばかりでした。",
  "絶対にまた来たい！この景色をもう一度見られることを願っています。",
  "こんなに美しい場所が本当に存在するなんて、信じられません！"
]


ActiveRecord::Base.transaction do
  3.times do
    users.each do |user_key, user|
      post = Post.find_or_initialize_by(user: user, title: titles.sample) do |post_data|
        post_data.body = body_comments[user_key].sample
        post_data.good = rand(0..5)
        post_data.night = Post.nights.keys.sample
        post_data.people = Post.people.keys.sample
        post_data.travelmonth = rand(1..12)
        post_data.season = Post.seasons.keys.sample
        post_data.place = Post.places.keys.sample
        post_data.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', image_files.sample)), filename: image_files.sample)
      end
      post.save!
      places_coordinates[user_key].each_with_index do |place_data, index|
        # 投稿に複数のPlaceを関連付け
        places_coordinates[user_key].each_with_index do |place_data, place_index|
          Place.find_or_create_by(post: post, place_name: place_data[:name]) do |place|
            place.latitude = place_data[:latitude]
            place.longitude = place_data[:longitude]
            place.comment = place_data[:comment]
            place.place_num = place_index + 1
            place.good = rand(0..5)
            place.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', image_files.sample)), filename: image_files.sample)
          end
        end
      end
      # ランダムにタグを追加
      selected_tags = tags.sample(3)
      selected_tags.each do |tag_name|
        tag = Tag.find_or_create_by(name: tag_name)
        PostTag.find_or_create_by(post: post, tag: tag)
      end

      # 都道府県を設定
      prefectures = case user_key
                    when :lucas_kyushu_to_okinawa
                      [40, 46]
                    when :judy_hokkaido_to_tohoku
                      [0, 1, 2, 3, 4]
                    when :lucas_kanto_to_chubu
                      [10, 11, 12, 13, 14, 15, 16, 17, 18]
                    when :olivia_kansai_to_chugoku
                      [24, 25, 26, 27, 28, 29]
                    end
      prefectures.each do |prefecture|
        PostPrefecture.find_or_create_by!(post_id: post.id, prefecture: prefecture)
      end

      if Rails.env.production?
        comment_users = User.where.not(id: user.id).order("RAND()").limit(3)
      else
        comment_users = User.where.not(id: user.id).order("RANDOM()").limit(3)
      end
      comment_users.each do |comment_user|
        comment_text = comments_sample.sample
        post.comments.create!(user: comment_user, comment: comment_text)
      end
    end
  end
end
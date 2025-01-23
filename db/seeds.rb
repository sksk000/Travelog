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
      night: 2,
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
      user: jiro,
      title: "ラーメン二郎何杯食べれるか",
      body: "大好きなラーメン二郎を1泊2日で巡ってみました。胃袋に自身はあったのですが合計3店舗しか行けなかった。。また時間作って二郎巡りしたいな～",
      good: 5,
      night: 0,
      people: 0,
      travelmonth: 12,
      image: "seedsimages/mita.jpg",
      places: [
        { name: "ラーメン二郎 三田本店", latitude: 35.648225621704078, longitude: 139.74164332559033, comment: "初めて三田本店にいきました、次も控えているためコールなしで注文！チャーシューがほろほろで染みた野菜が美味しすぎる・・。麺は少し柔めで太さもあり食べ応えがある！最高でした。。", image: "seedsimages/mita_jiro.jpg", good: 5 },
        { name: "ラーメン二郎 神田神保町店", latitude: 35.69527613138069, longitude: 139.7609022274397, comment: "こちらも初めての訪問、あの「レベルの高い合格点を超える二郎 オールウェイズ出してくれる」でおなじみの場所。食べ切れるか分からないので麺少なめに。三田本店より量多き気がするのはきのせい？けど美味しかった～～！", image: "seedsimages/jinbo_jiro.jpg", good: 5 },
        { name: "アパホテル(神田神保町駅東)", latitude: 35.69470617799219, longitude: 139.76230085385862, comment: "ラーメン二郎の近くだったのでココに決めました、普通によかった。", image: "seedsimages/jinbo_hotel.jpg", good: 3 },
        { name: "ラーメン二郎 亀戸店", latitude: 35.70211547237266, longitude: 139.82667742559218, comment: "何回か訪問した亀戸二郎、チャーシュー最高すぎ・・。醤油のキレがよくて麺とよくあって美味しい。今度は選択肢として汁なしも検討しよう。", image: "seedsimages/kameido_jiro.jpg", good: 5 },
      ],
      tags: ["二郎", "ジロリアン"],
      prefectures: [12],
      comments: [
        { user: "いっちゃん", text: "そんなに食べたの！？すごーい！！！前、夫といっしょに二郎系行ったとき1杯で動けないぐらいお腹いっぱいだった。。" },
      ]
    },
    icchan_okinawa: {
      user: icchan,
      title: "2泊3日沖縄の旅",
      body: "夫といっしょに初めての沖縄へいきました。大好きなお肉、更には素敵な景色を堪能できました！！沖縄さいこ～～",
      good: 5,
      night: 1,
      people: 1,
      travelmonth: 12,
      image: "seedsimages/okinawa.jpg",
      places: [
        { name: "沖縄美ら海水族館", latitude: 26.694558438731132, longitude: 127.87807746950608, comment: "ジンベイザメってこんなに大きいとは思ってなかった・・。イルカショーも素晴らしく、ダンスや歌など披露していてとてもかわいかった❤", image: "seedsimages/suizokukan.jpg", good: 5 },
        { name: "ナゴパイナップルパーク", latitude: 26.616684117755728, longitude: 127.969445649902, comment: "入口からパイナップルずくしで、写真映えしますね！！！パイナップルのソフトクリームを食べたのですが、パイナップル好きには最高です！", image: "seedsimages/nago.jpg", good: 5 },
        { name: "ルネッサンス沖縄リゾート", latitude: 26.43556510131538, longitude: 127.78775958465835, comment: "館内が充実していて、海やプールがあり更には卓球台がありました！館内をお散歩するだけでもとても楽しい♪", image: "seedsimages/okinawa_hotel.jpg", good: 5 },
        { name: "JUMBO STEAK HAN’S", latitude: 26.220789375102953, longitude: 127.67798355456107, comment: "お肉！！！ステーキを頂きました！肉肉しく美味！！", image: "seedsimages/steak.jpg", good: 4 },
        { name: "アメリカンビレッジ", latitude: 26.216403925786135, longitude: 127.68360056672182, comment: "めちゃくちゃ写真映えするような建物がいっぱい！日本じゃないみたい！！", image: "seedsimages/americanvillage.jpg", good: 5 },
      ],
      tags: ["沖縄","パイナップル","アメリカン","肉"],
      prefectures: [46],
      comments: [
        { user: "サンサン", text: "写真映えしますね～！僕も今度カメラ持って沖縄行こうかな" },
        { user: "よん様", text: "素敵～～！！夫婦仲良くて羨ましい～～！" },
        { user: "食べ過ぎ二郎", text: "おお～！お肉大きいですね！！Tボーンステーキ食べてみたいな・・" },
      ]
    },
    sunsun_kyoto: {
      user: sun,
      title: "紅葉の京都巡り",
      body: "友人と紅葉シーズンに京都へ行きました。素晴らしい秋の景色が広がっておりカメラを手放せない程夢中で撮影していました。",
      good: 5,
      night: 1,
      people: 2,
      travelmonth: 10,
      image: "seedsimages/kyoto.jpg",
      places: [
        { name: "清水寺", latitude: 34.99488334011819, longitude: 135.78460611448176, comment: "ライトアップされた紅葉はとても素敵で、写真映えします。", image: "seedsimages/kiyomizu.jpg", good: 5 },
        { name: "嵐山", latitude: 35.010005664857914, longitude: 135.66698377974177, comment: "竹林の道を散歩しながら紅葉を満喫！心が洗われるような美しさでした。", image: "seedsimages/arashiyama.jpg", good: 4 },
        { name: "嵐山温泉 花伝抄", latitude: 35.010821413612234, longitude: 135.68030087748085, comment: "枕を選べることに感動！ぐっすり休むことができた。夕食は旬の食材を利用した料理ばかりで、とても美味でした。", image: "seedsimages/onsen.jpg", good: 5 },
        { name: "祇園辻利 祇園本店", latitude: 35.00392482034129, longitude: 135.77449414015916, comment: "濃厚な抹茶パフェが絶品で、あまり甘いものが得意でない僕でも食べれちゃう一品", image: "seedsimages/matcha.jpg", good: 5 },
      ],
      tags: ["紅葉", "寺", "和スイーツ", "温泉"],
      prefectures: [25],
      comments: [
        { user: "いっちゃん", text: "紅葉シーズンの京都、憧れます！私も夫といつか行きたいな～" },
        { user: "よん様", text: "抹茶パフェおいしそう～！京都の秋は本当に素敵ですよね。" }
      ]
    },
    yonsama_nagano: {
      user: yonsama,
      title: "長野へハイキング旅！",
      body: "最近お酒ばかり飲んで不健康なので、久々にハイキングに来ました。空気が美味しい！！帰りはアウトレットでぷち贅沢❤",
      good: 7,
      night: 2,
      people: 1,
      travelmonth: 8,
      image: "seedsimages/nagano.jpg",
      places: [
        { name: "白馬岳", latitude: 36.75901332723854, longitude: 137.75863385063687, comment: "山の景色が素晴らしく、ハイキングが楽しかった！", image: "seedsimages/hakuba.jpg", good: 5 },
        { name: "星のや軽井沢", latitude: 36.35823590305051, longitude: 138.59086918127068, comment: "敷地内は自然が多く、素晴らしい景観で散歩しているだけでも楽しめる素晴らしいホテルです。", image: "seedsimages/karuizawa_hotel.jpg", good: 4 },
        { name: "軽井沢・プリンスショッピングプラザ", latitude: 36.340863824135084, longitude: 138.63600066697595, comment: "アウトレットで散財！", image: "seedsimages/karuizawa_shopping.jpg", good: 5 }
      ],
      tags: ["夏", "避暑地", "自然"],
      prefectures: [19],
      comments: [
        { user: "いっちゃん", text: "軽井沢行ってみたんだけど、なかなか機会がないのよね。。" },
        { user: "サンサン", text: "景色すばらしいですね～ハイキング運動不足な僕が行けるものかな・・？気になる。。" }
      ]
    },
    icchan_oosaka: {
      user: icchan,
      title: "夫婦大阪くいだおれ旅",
      body: "夫と一緒に大阪旅！たこ焼きがトロトロで美味しかった～またいきたい！",
      good: 4,
      night: 0,
      people: 1,
      travelmonth: 6,
      image: "seedsimages/osaka.jpg",
      places: [
        { name: "なんばグランド花月", latitude: 34.66500527562112, longitude: 135.50365664496508, comment: "実際に見る新喜劇は迫力があって面白かった！", image: "seedsimages/nanba.jpg", good: 5 },
        { name: "たこ焼道楽わなか", latitude: 34.66522105846767, longitude: 135.5034102404898, comment: "今まで食べたたこ焼きと違って熱々トロトロで出汁が効いて美味しい～！！", image: "seedsimages/takoyaki.jpg", good: 5 },
        { name: "新世界串カツいっとく難波千日前店", latitude: 34.66658510138467, longitude: 135.5020055862774, comment: "熱々の串カツが最高！衣も薄くてサクサクで美味しい～～！", image: "seedsimages/ittoku.jpg", good: 5 },
        { name: "大阪シティホテル", latitude: 34.6956923477765, longitude: 135.53030622225143, comment: "駅前で便利でした！", image: "seedsimages/osaka_hotel.jpg", good: 4 }
      ],
      tags: ["大阪", "グルメ", "串カツ", "たこ焼き"],
      prefectures: [26],
      comments: [
        { user: "よん様", text: "串カツいいな～ビールで優勝したい・・！" },
        { user: "食べ過ぎ二郎", text: "たこ焼きおいしそう！今度出張で大阪へ行くから参考にします！" }
      ]
    },
    jiro_hakata: {
      user: jiro,
      title: "ラーメン好きによる博多ラーメン巡り",
      body: "博多の豚骨ラーメン制覇する勢いで、福岡の有名なラーメンを食べてきました！最高だった・・・",
      good: 4,
      night: 0,
      people: 0,
      travelmonth: 3,
      image: "seedsimages/hakata.jpg",
      places: [
        { name: "横浜家系総本山 吉村家直系店 ラーメン内田家", latitude: 33.58776555474664, longitude: 130.4161207911657, comment: "あの有名な吉村家の直系店！麺硬め・油普通・スープ普通で注文、本家と違い塩気がありこれもまたうま～！", image: "seedsimages/utidaya.jpg", good: 5 },
        { name: "ホテルモントレ福岡", latitude: 33.58480827537479, longitude: 130.40461122148622, comment: "奮発していいホテル泊まった！とてもきれいで朝食も素晴らしかった！", image: "seedsimages/fukuoka_hotel.jpg", good: 5 },
        { name: "一幸舎 博多デイトス店", latitude: 33.59118122134132, longitude: 130.42128811869242, comment: "泡が立つほど濃厚な豚骨スープで、とてもクリーミな味！美味しすぎて替え玉2回しちゃった・・。", image: "seedsimages/ikkosya.jpg", good: 4 },
        { name: "博多らーめん ShinShin KITTE博多店", latitude: 33.588882778939755, longitude: 130.41944499668796, comment: "30分ぐらい並んだかな・・？結構あっさりめで食べやすかった！", image: "seedsimages/shinshin.jpg", good: 3 }
      ],
      tags: ["博多", "ラーメン", "グルメ"],
      prefectures: [39],
      comments: [
        { user: "よん様", text: "ラーメン本当に好きなんですね！美味しそう～～！！お腹空いてきた。。" },
        { user: "いっちゃん", text: "美味しそう！！豚骨ラーメンあまり食べないのですが、今度どこかの豚骨ラーメンチャレンジしてみようかな？？" }
      ]
    },
    yonsama_aomori: {
      user: yonsama,
      title: "海鮮食べ歩き旅in青森",
      body: "青森で普段食べれないような新鮮な海鮮を食べながらお酒イッパイ飲んできました！海鮮もそうだけど地元のお酒が美味しくてよかった～！",
      good: 4,
      night: 2,
      people: 1,
      travelmonth: 4,
      image: "seedsimages/hatinohe.jpg",
      places: [
        { name: "八食センター", latitude: 40.52654410225081, longitude: 141.45288251722005, comment: "ここは市場なのですが、買った海鮮を七輪で焼けるとのこと！新鮮な魚や貝を焼きながらビール飲むのさいこ～！！", image: "seedsimages/hassyoku.jpg", good: 5 },
        { name: "蕪島神社", latitude: 40.53903091188966, longitude: 141.557497758868, comment: "ここはうみねこの繁殖地として国の天然記念物に指定されている場所だそうです！", image: "seedsimages/kabushima.jpg", good: 5 },
        { name: "種差海岸", latitude: 40.50089461522884, longitude: 141.6232235921508, comment: "久々の海！眺めがきれいでずっと居たいぐらいだった！", image: "seedsimages/tanesashi.jpg", good: 4 },
        { name: "みろく横丁", latitude: 40.50927397648278, longitude: 141.49088584015178, comment: "居酒屋さんが沢山あり、どこに行こうか迷っちゃった。。どの居酒屋入っても料理が美味しくてお酒が進んじゃった", image: "seedsimages/miroku.jpg", good: 4 },
        { name: "ドーミーイン本八戸", latitude: 40.50986629447922, longitude: 141.49256671279645, comment: "ドーミイン名物の夜鳴きそば！美味しかったな～！", image: "seedsimages/yonakisoba.jpg", good: 4 },
        { name: "館鼻岸壁朝市", latitude: 40.528075675440654, longitude: 141.52937311000812, comment: "決まった日曜に開催されている朝市！！朝早起きして訪れました！寒い中食べるせんべい汁は格別だったな～", image: "seedsimages/hatinohe_asaiti.jpg", good: 4 }
      ],
      tags: ["東北", "桜", "花見"],
      prefectures: [1],
      comments: [
        { user: "サンサン", text: "八食センターいいですよね～中にある回転寿司も新鮮で美味しいですよ！今度行く際は立ち寄ってみてください" },
        { user: "いっちゃん", text: "また食べ歩きしている！！いいな～～私も旦那と食べ歩き旅してこようかな～～" }
      ]
    },
    sunsun_kanazawa: {
      user: sun,
      title: "金沢ひとり旅",
      body: "初めての金沢へ訪問しました。何より景色が素晴らしく、心が洗われるようでした！",
      good: 5,
      night: 0,
      people: 0,
      travelmonth: 4,
      image: "seedsimages/kanazawa.jpg",
      places: [
        { name: "兼六園", latitude: 36.5623, longitude: 136.6625, comment: "日本らしさを感じられる場所だった。また季節に応じて景色が異なり、これもまた素晴らしいとのこと。今度は冬に訪れたい。", image: "seedsimages/kenrokuen.jpg", good: 5 },
        { name: "金沢城公園", latitude: 36.56608364575496, longitude: 136.65892019863406, comment: "広々とした敷地内の中で散歩するのは気持ちが良かった！", image: "seedsimages/kouen.jpg", good: 5 },
        { name: "ひがし茶屋街", latitude: 36.57305410777007, longitude: 136.66667840789316, comment: "古い町並みと石畳の道が素敵だった。お土産屋さんやカフェ等充実しており、見るだけでも楽しい。", image: "seedsimages/higasityayamati.jpg", good: 5 },
        { name: "ホテルマイステイズ金沢キャッスル", latitude: 36.57847251794336, longitude: 136.65249218329276, comment: "とてもリーズナブルで金沢駅前でアクセスしやすかった。", image: "seedsimages/kanazawa_hotel.jpg", good: 4 }
      ],
      tags: ["石川", "歴史"],
      prefectures: [16],
      comments: [
        { user: "食べ過ぎ二郎", text: "景色がすばらしい！あまりこういう場所にいかないから新鮮な気持ちになりました！" },
        { user: "いっちゃん", text: "金沢は一度夫といったことがあるけど、やっぱ素敵よね～～！またいきたくなっちゃう" },
        { user: "よん様", text: "あら素敵～！！景色がきれいで写真映えしますね！私もいってみたい～" }
      ]
    }
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

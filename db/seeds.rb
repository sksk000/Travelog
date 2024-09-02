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
end

judy_post = Post.find_or_create_by!(user: judy) do |post_data|
  post_data.user = judy
  post_data.title = "福岡へ行った"
  post_data.body = "日本の歴史を感じれた"
  post_data.good = 2
  post_data.season = 1
  post_data.place = 1
  post_data.night = 2
  post_data.people = 3
end

Place.create(post: judy_post, place_name: "国会議事堂", address: "東京都千代田区永田町１丁目７−１", comment:"国会議事堂は大きかった", place_num: 1)
Place.create(post: judy_post, place_name: "xxxxx", address: "東京都墨田区東向島４丁目２８−１６", comment:"素敵", place_num: 2)



olivia = User.find_or_create_by!(email: "olivia@example.com") do |user|
  user.name = "Olivia"
  user.password = "password"
end

olivia_post = Post.find_or_create_by!(user: olivia) do |post_data|
  post_data.user = olivia
  post_data.title = "群馬へ行った"
  post_data.body = "日本の歴史を感じれた"
  post_data.good = 2
  post_data.season = 1
  post_data.place = 1
  post_data.night = 2
  post_data.people = 3
end

Place.create(post: judy_post, place_name: "赤城南面千本桜", address: "群馬県前橋市苗ヶ島町２５１１−２", comment:"美しかった", place_num: 1)
Place.create(post: judy_post, place_name: "鳥取城跡", address: "群馬県前橋市鳥取町３０９−２", comment:"素敵", place_num: 2)




lucas = User.find_or_create_by!(email: "lucas@example.com") do |user|
  user.name = "Lucas"
  user.password = "password"
end





Admin.find_or_create_by!(email: "example@example.com") do |admin|
  admin.password = "password"
end


# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

olivia = User.find_or_create_by!(email: "olivia@example.com") do |user|
  user.name = "Olivia"
  user.password = "password"
end

olivia_post = Post.find_or_create_by!(user: olivia) do |post_data|
  post_data.user = olivia
  post_data.title = "沖縄に来てみた"
  post_data.body = "素敵な海を見れた！"
end

lucas = User.find_or_create_by!(email: "lucas@example.com") do |user|
  user.name = "Lucas"
  user.password = "password"
end

lucas_post = Post.find_or_create_by!(user: lucas) do |post_data|
  post_data.user = lucas
  post_data.title = "北海道に来てみた"
  post_data.body = "海鮮が美味しかった"
end

Comment.find_or_create_by!(post_id: olivia_post.id) do |comment_data|
  comment_data.post_id = olivia_post.id
  comment_data.comment = "ルーカスだよ！"
  comment_data.user_id = lucas.id
end

Comment.find_or_create_by!(post_id: lucas_post.id) do |comment_data|
  comment_data.post_id = lucas_post.id
  comment_data.comment = "オリヴィアだよ！"
  comment_data.user_id = olivia.id
end

Admin.find_or_create_by!(email: "example@example.com") do |admin|
  admin.password = "password"
end


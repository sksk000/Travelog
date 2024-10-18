# frozen_string_literal: true
require 'rails_helper'


RSpec.describe do
  describe '投稿のテスト' do
    before do
      @user = FactoryBot.create(:user)
      sign_in @user
    end

    context '記事投稿のテスト' do
      it '記事投稿・観光場所設定後新規投稿を行う' do
        visit new_post_path
        expect(current_path).to eq(new_post_path)

        #Postのデータ作成
        title = Faker::Lorem.characters(number:10)
        body = Faker::Lorem.characters(number:30)
        place_name = Faker::Lorem.characters(number:10)
        address = "東京都港区芝公園４丁目２−８"
        comment = Faker::Lorem.characters(number:10)

        #記事投稿内容作成
        fill_in 'post[title]', with: title
        fill_in 'post[body]', with: body
        select '春', from: 'post[season]'
        select '国内旅行', from: 'post[place]'
        select '四泊', from: 'post[night]'
        select '二人', from: 'post[people]'

        expect(page).to have_button '下書きとして観光場所指定へ進む'
        click_button '下書きとして観光場所指定へ進む'

        expect(page).to have_current_path new_post_places_path(Post.last.id)

        #観光場所指定
        fill_in 'place[place_name]', with: place_name
        fill_in 'place[address]', with: address
        select '新規追加', from: 'place[place_num]'
        fill_in 'place[comment]', with: comment

        click_button '登録'

        expect(page).to have_current_path post_path(Post.last.id)
      end

      it '投稿削除' do
        post = FactoryBot::create(:post, user: @user)
        place = FactoryBot::create(:place, post: post)
        expect(Post.count).to eq(1)
        expect(Place.count).to eq(1)

        visit post_path(post.id)
        expect(page).to have_current_path post_path(post.id)

        expect(page).to have_link('削除')
        click_on '削除'

        expect(Post.count).to eq(0)
        expect(Place.count).to eq(0)

      end

      it '投稿編集' do
        post = FactoryBot::create(:post, user: @user)
        FactoryBot::create(:place, post: post)
        expect(Post.count).to eq(1)
        expect(Place.count).to eq(1)

        visit post_path(post.id)
        expect(page).to have_current_path post_path(post.id)

        expect(page).to have_link('編集')
        click_on '編集'

        expect(page).to have_current_path edit_post_path(post.id)

        #Postのデータ作成
        title = Faker::Lorem.characters(number:10)
        body = Faker::Lorem.characters(number:30)
        place_name = Faker::Lorem.characters(number:10)
        address = "東京都墨田区押上１丁目１−２"
        comment = Faker::Lorem.characters(number:10)

        #記事投稿内容作成
        fill_in 'post[title]', with: title
        fill_in 'post[body]', with: body
        select '春', from: 'post[season]'
        select '国内旅行', from: 'post[place]'
        select '四泊', from: 'post[night]'
        select '二人', from: 'post[people]'

        expect(page).to have_button '観光場所変更へ移動'
        click_button '観光場所変更へ移動'

        #観光場所指定
        fill_in 'place[1][place_name]', with: place_name
        fill_in 'place[1][address]', with: address
        fill_in 'place[1][comment]', with: comment

        click_button '更新'
        expect(page).to have_current_path post_path(Post.last.id)
      end
    end
  end
end


# frozen_string_literal: true
require 'rails_helper'


RSpec.describe Public::SearchesController, type: :controller do
  describe '検索絞り込みテスト' do
    before(:each) do
      user_jack = FactoryBot.create(:user, name: 'jack')
      FactoryBot.create(:user, name: 'jacks')
      FactoryBot.create(:post, user: user_jack, title: 'aaabbb', season: 0, place: 0, night: 0, people: 0)
      FactoryBot.create(:post, user: user_jack, title: 'aaa', season: 1, place: 1, night: 1, people: 1)
      FactoryBot.create(:post, user: user_jack, season: 2, place: 0, night: 2, people: 2)
      FactoryBot.create(:post, user: user_jack, season: 3, place: 1, night: 3, people: 3)
    end

    it 'データ確認' do
      expect(Post.count).to eq(4)
      expect(User.count).to eq(2)

    end

    it '季節が春の場合' do
      get :search, params: { seachdata: "", is_search_category: "Post", is_search_condition: "PartialMatch", is_search_season: "春", is_search_place: "all_places", is_search_night: "all_nights", is_search_people: "all_people" }

      expect(response).to render_template('result')

      #resultのViewに渡されている@postが、すべてseason=='春'の場合テスト成功となる
      expect(assigns(:post).count).to eq(1)
      expect(assigns(:post).pluck(:season)).to all( eq('春') )
    end

    it '場所が海外の場合' do
      get :search, params: { seachdata: "", is_search_category: "Post", is_search_condition: "PartialMatch", is_search_season: "all_seasons", is_search_place: "国内旅行", is_search_night: "all_nights", is_search_people: "all_people" }

      expect(response).to render_template('result')

      #resultのViewに渡されている@postが、すべてseason=='春'の場合テスト成功となる
      expect(assigns(:post).count).to eq(2)
      expect(assigns(:post).pluck(:place)).to all( eq('国内旅行') )
    end

    it '宿泊日数が二泊の場合' do
      get :search, params: { seachdata: "", is_search_category: "Post", is_search_condition: "PartialMatch", is_search_season: "all_seasons", is_search_place: "all_places", is_search_night: "二泊", is_search_people: "all_people" }

      expect(response).to render_template('result')

      #resultのViewに渡されている@postが、すべてseason=='春'の場合テスト成功となる
      expect(assigns(:post).count).to eq(1)
      expect(assigns(:post).pluck(:night)).to all( eq('二泊') )
    end

    it '宿泊人数が四人の場合' do
      get :search, params: { seachdata: "", is_search_category: "Post", is_search_condition: "PartialMatch", is_search_season: "all_seasons", is_search_place: "all_places", is_search_night: "all_nights", is_search_people: "四人" }

      expect(response).to render_template('result')

      #resultのViewに渡されている@postが、すべてseason=='春'の場合テスト成功となる
      expect(assigns(:post).count).to eq(1)
      expect(assigns(:post).pluck(:people)).to all( eq('四人') )
    end

    it 'Userのキーワード検索にて完全一致検索する場合' do
      get :search, params: { seachdata: "jacks", is_search_category: "User", is_search_condition: "PerfectMatch", is_search_season: "all_seasons", is_search_place: "all_places", is_search_night: "all_nights", is_search_people: "all_people" }

      expect(response).to render_template('result')

      #resultのViewに渡されている@postが、すべてseason=='春'の場合テスト成功となる
      expect(assigns(:user).count).to eq(1)
      expect(assigns(:user).pluck(:name)).to all( eq('jacks') )
    end
    it 'Userのキーワード検索にて部分一致検索する場合' do
      get :search, params: { seachdata: "jack", is_search_category: "User", is_search_condition: "PartialMatch", is_search_season: "all_seasons", is_search_place: "all_places", is_search_night: "all_nights", is_search_people: "all_people" }

      expect(response).to render_template('result')

      #resultのViewに渡されている@postが、すべてseason=='春'の場合テスト成功となる
      expect(assigns(:user).count).to eq(2)
    end

    it 'Postのキーワード検索にて部分一致検索する場合' do
      get :search, params: { seachdata: "aaa", is_search_category: "Post", is_search_condition: "PartialMatch", is_search_season: "all_seasons", is_search_place: "all_places", is_search_night: "all_nights", is_search_people: "all_people" }

      expect(response).to render_template('result')

      #resultのViewに渡されている@postが、すべてseason=='春'の場合テスト成功となる
      expect(assigns(:post).count).to eq(2)
    end

    it 'Postのキーワード検索にて完全一致検索する場合' do
      get :search, params: { seachdata: "aaabbb", is_search_category: "Post", is_search_condition: "PartialMatch", is_search_season: "all_seasons", is_search_place: "all_places", is_search_night: "all_nights", is_search_people: "all_people" }

      expect(response).to render_template('result')

      #resultのViewに渡されている@postが、すべてseason=='春'の場合テスト成功となる
      expect(assigns(:post).count).to eq(1)
    end

    it '検索条件を部分一致、検索カテゴリを投稿にし、キーワード検索に何も入力していない場合' do
      get :search, params: { seachdata: "", is_search_category: "Post", is_search_condition: "PartialMatch", is_search_season: "all_seasons", is_search_place: "all_places", is_search_night: "all_nights", is_search_people: "all_people" }

      expect(response).to render_template('result')

      #resultのViewに渡されている@postが、すべてseason=='春'の場合テスト成功となる
      expect(assigns(:post).count).to eq(4)
    end

    it '検索条件を完全一致、検索カテゴリを投稿にし、キーワード検索に何も入力していない場合' do
      get :search, params: { seachdata: "", is_search_category: "Post", is_search_condition: "PerfectMatch", is_search_season: "all_seasons", is_search_place: "all_places", is_search_night: "all_nights", is_search_people: "all_people" }

      expect(response).to render_template('result')

      #resultのViewに渡されている@postが、すべてseason=='春'の場合テスト成功となる
      expect(assigns(:post).count).to eq(0)
    end

    it '検索条件を部分一致、検索カテゴリをユーザにし、キーワード検索に何も入力していない場合' do
      get :search, params: { seachdata: "", is_search_category: "User", is_search_condition: "PartialMatch", is_search_season: "all_seasons", is_search_place: "all_places", is_search_night: "all_nights", is_search_people: "all_people" }

      expect(response).to render_template('result')

      #resultのViewに渡されている@postが、すべてseason=='春'の場合テスト成功となる
      expect(assigns(:user).count).to eq(2)
    end

    it '検索条件を完全一致、検索カテゴリをユーザにし、キーワード検索に何も入力していない場合' do
      get :search, params: { seachdata: "", is_search_category: "User", is_search_condition: "PerfectMatch", is_search_season: "all_seasons", is_search_place: "all_places", is_search_night: "all_nights", is_search_people: "all_people" }

      expect(response).to render_template('result')

      #resultのViewに渡されている@postが、すべてseason=='春'の場合テスト成功となる
      expect(assigns(:user).count).to eq(0)
    end
  end
end

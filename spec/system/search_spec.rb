# frozen_string_literal: true
require 'rails_helper'


RSpec.describe do
  describe '検索絞り込みテスト' do
    before(:each) do
      @user_jack = FactoryBot.create(:user, name: 'jack')
      FactoryBot.create(:user, name: 'jacks')
      FactoryBot.create(:post, user: @user_jack, title: 'aaabbb', season: 0, place: 0, night: 0, people: 0)
      FactoryBot.create(:post, user: @user_jack, title: 'aaa', season: 1, place: 1, night: 1, people: 1)
      FactoryBot.create(:post, user: @user_jack, season: 2, place: 0, night: 2, people: 2)
      FactoryBot.create(:post, user: @user_jack, season: 3, place: 1, night: 3, people: 3)
    end

    it 'データ確認' do
      expect(Post.count).to eq(4)
      expect(User.count).to eq(2)

    end

    it '季節が春の場合' do
      sign_in @user_jack
      visit posts_path
      expect(current_path).to eq(posts_path)

      select 'Post', from: 'is_search_category'
      select '春', from: 'is_search_season'
      select '全旅行先', from: 'is_search_place'
      select '指定なし', from: 'is_search_night'
      select '指定なし', from: 'is_search_people'

      click_button '検索'

      expect(page.all('a', text: '季節:春').count).to eq 1

    end

    it '場所が海外の場合' do
      sign_in @user_jack
      visit posts_path
      expect(current_path).to eq(posts_path)

      select 'Post', from: 'is_search_category'
      select '全季節', from: 'is_search_season'
      select '海外旅行', from: 'is_search_place'
      select '指定なし', from: 'is_search_night'
      select '指定なし', from: 'is_search_people'

      click_button '検索'

      expect(page.all('a', text: '旅行先:海外旅行').count).to eq 2
    end

    it '宿泊日数が二泊の場合' do
      sign_in @user_jack
      visit posts_path
      expect(current_path).to eq(posts_path)

      select 'Post', from: 'is_search_category'
      select '全季節', from: 'is_search_season'
      select '全旅行先', from: 'is_search_place'
      select '二泊', from: 'is_search_night'
      select '指定なし', from: 'is_search_people'

      click_button '検索'

      expect(page.all('a', text: '宿泊数:二泊').count).to eq 1
    end

    it '宿泊人数が四人の場合' do
      sign_in @user_jack
      visit posts_path
      expect(current_path).to eq(posts_path)

      select 'Post', from: 'is_search_category'
      select '全季節', from: 'is_search_season'
      select '全旅行先', from: 'is_search_place'
      select '指定なし', from: 'is_search_night'
      select '四人', from: 'is_search_people'

      click_button '検索'

      expect(page.all('a', text: '人数:四人').count).to eq 1
    end

    it 'Userのキーワード検索にて完全一致検索する場合' do
      sign_in @user_jack
      visit posts_path
      expect(current_path).to eq(posts_path)

      fill_in 'seachdata', with: 'jacks'
      select 'User', from: 'is_search_category'
      select 'PerfectMatch', from: 'is_search_condition'
      select '全季節', from: 'is_search_season'
      select '全旅行先', from: 'is_search_place'
      select '指定なし', from: 'is_search_night'
      select '指定なし', from: 'is_search_people'

      click_button '検索'

      expect(page.all('a', text: 'jacks').count).to eq 0
    end

    it 'Userのキーワード検索にて部分一致検索する場合' do
      sign_in @user_jack
      visit posts_path
      expect(current_path).to eq(posts_path)

      fill_in 'seachdata', with: 'jack'
      select 'User', from: 'is_search_category'
      select 'PartialMatch', from: 'is_search_condition'
      select '全季節', from: 'is_search_season'
      select '全旅行先', from: 'is_search_place'
      select '指定なし', from: 'is_search_night'
      select '指定なし', from: 'is_search_people'

      click_button '検索'

      expect(page.all('a', text: 'jack').count).to eq 4
    end

    it 'Postのキーワード検索にて部分一致検索する場合' do
      sign_in @user_jack
      visit posts_path
      expect(current_path).to eq(posts_path)

      fill_in 'seachdata', with: 'jack'
      select 'User', from: 'is_search_category'
      select 'PartialMatch', from: 'is_search_condition'
      select '全季節', from: 'is_search_season'
      select '全旅行先', from: 'is_search_place'
      select '指定なし', from: 'is_search_night'
      select '指定なし', from: 'is_search_people'

      click_button '検索'

      expect(page.all('a', text: 'jack').count).to eq 4
    end

    it 'Postのキーワード検索にて完全一致検索する場合' do
      sign_in @user_jack
      visit posts_path
      expect(current_path).to eq(posts_path)

      fill_in 'seachdata', with: 'aaabbb'
      select 'Post', from: 'is_search_category'
      select 'PerfectMatch', from: 'is_search_condition'
      select '全季節', from: 'is_search_season'
      select '全旅行先', from: 'is_search_place'
      select '指定なし', from: 'is_search_night'
      select '指定なし', from: 'is_search_people'

      click_button '検索'

      expect(page.all('a', text: 'aaabbb').count).to eq 1
    end

    it '検索条件を部分一致、検索カテゴリを投稿にし、キーワード検索に何も入力していない場合' do
      sign_in @user_jack
      visit posts_path
      expect(current_path).to eq(posts_path)

      fill_in 'seachdata', with: ''
      select 'Post', from: 'is_search_category'
      select 'PartialMatch', from: 'is_search_condition'
      select '全季節', from: 'is_search_season'
      select '全旅行先', from: 'is_search_place'
      select '指定なし', from: 'is_search_night'
      select '指定なし', from: 'is_search_people'

      click_button '検索'

      expect(page.all('a', text: 'jack').count).to eq 4
    end

    it '検索条件を完全一致、検索カテゴリを投稿にし、キーワード検索に何も入力していない場合' do
      sign_in @user_jack
      visit posts_path
      expect(current_path).to eq(posts_path)

      fill_in 'seachdata', with: ''
      select 'Post', from: 'is_search_category'
      select 'PerfectMatch', from: 'is_search_condition'
      select '全季節', from: 'is_search_season'
      select '全旅行先', from: 'is_search_place'
      select '指定なし', from: 'is_search_night'
      select '指定なし', from: 'is_search_people'

      click_button '検索'

      expect(page.all('a', text: 'jack').count).to eq 0
    end

    it '検索条件を部分一致、検索カテゴリをユーザにし、キーワード検索に何も入力していない場合' do
      sign_in @user_jack
      visit posts_path
      expect(current_path).to eq(posts_path)

      fill_in 'seachdata', with: ''
      select 'User', from: 'is_search_category'
      select 'PartialMatch', from: 'is_search_condition'
      select '全季節', from: 'is_search_season'
      select '全旅行先', from: 'is_search_place'
      select '指定なし', from: 'is_search_night'
      select '指定なし', from: 'is_search_people'

      click_button '検索'

      expect(page.all('a', text: 'jack').count).to eq 4
    end

    it '検索条件を完全一致、検索カテゴリをユーザにし、キーワード検索に何も入力していない場合' do
      sign_in @user_jack
      visit posts_path
      expect(current_path).to eq(posts_path)

      fill_in 'seachdata', with: ''
      select 'User', from: 'is_search_category'
      select 'PerfectMatch', from: 'is_search_condition'
      select '全季節', from: 'is_search_season'
      select '全旅行先', from: 'is_search_place'
      select '指定なし', from: 'is_search_night'
      select '指定なし', from: 'is_search_people'

      click_button '検索'

      expect(page.all('a', text: 'jack').count).to eq 0
    end
  end
end

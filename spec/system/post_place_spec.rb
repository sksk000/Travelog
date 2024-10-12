# frozen_string_literal: true
require 'rails_helper'

Rspec.describe Public::SearchesController
describe '投稿のテスト' do
  before do
   # @user = FactoryBot.create(:user)
    #@post = FactoryBot.build(:post, user_id: @user.id)
  end
  context '記事投稿のテスト'
    it '記事投稿後、観光場所指定ページに遷移するか' do
      sign_in @user
      visit new_post_path
      expect(page).to have_button('下書きとして観光場所指定へ進む')

      click_button '下書きとして観光場所指定へ進む'
      #expect(page).to have_current_path new_post_places_path
    end

    context '観光場所指定ページの設定' do
      #visit new_post_places(@post.id)
    end
end


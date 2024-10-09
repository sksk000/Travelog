# frozen_string_literal: true
require 'rails_helper'


describe '投稿のテスト' do
  before do
    @user = FactoryBot.create(:user)

  end
  context '表示の確認'
   it '「下書きとして観光場所指定へ進む」が表示されているか' do
     sign_in @user
     visit new_post_path
     expect(page).to have_content '下書きとして観光場所指定へ進む'
   end

  context '投稿処理のテスト' do
    it '記事作成後、観光場所指定ページにリダイレクトするか' do


    end
  end
end

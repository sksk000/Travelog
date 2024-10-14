# frozen_string_literal: true
require 'rails_helper'


RSpec.describe do
  describe '投稿のテスト' do
    before do
      @name = "test"
      @password = Faker::Internet.password(min_length: 6)
      @email = Faker::Internet.email

      visit root_path
      expect(page).to have_current_path root_path
    end

    context 'ユーザテスト' do
      it 'ユーザ登録テスト' do
        expect(page).to have_link('Sign up')
        click_on 'Sign up'

        fill_in 'user[name]', with: @name
        fill_in 'user[email]', with: @email
        fill_in 'user[password]', with: @password
        fill_in 'user[password_confirmation]', with: @password

        expect(page).to have_button('Sign up')
        click_button 'Sign up'

        expect(User.count).to eq(1)

        expect(page).to have_current_path root_path
      end

      it 'ユーザ情報編集テスト' do
        user = FactoryBot.create(:user)
        sign_in user

        visit mypage_path(user.id)

        expect(page).to have_link('ユーザ情報編集')
        click_link 'ユーザ情報編集'

        expect(page).to have_current_path infomation_users_path

        fill_in 'user[email]', with: Faker::Internet.email

        expect(page).to have_button('Update')
        click_button 'Update'

        expect(page).to have_current_path mypage_path(user.id)

      end

      it 'ユーザ削除テスト' do
        user = FactoryBot.create(:user)
        sign_in user

        visit mypage_path(user.id)

        expect(page).to have_link('ユーザ情報編集')
        click_link 'ユーザ情報編集'

        expect(page).to have_current_path infomation_users_path

        expect(page).to have_link('退会')
        click_link '退会'

        expect(page).to have_current_path root_path
      end

    end
  end
end


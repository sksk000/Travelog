# frozen_string_literal: true
require 'rails_helper'


describe '検索テスト' do
  before do
    @user = FactoryBot.create(:user)
    @post = FactoryBot.build(:post, user_id: @user.id)
  end
 
end

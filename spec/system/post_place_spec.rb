# frozen_string_literal: true
require 'rails_helper'

Rspec.describe Public::SearchesController, type: :controlelr do
  describe '投稿のテスト' do
    before do
      user_jack = FactoryBot.create(:user, name: 'jack')
      user_mic = FactoryBot.create(:user, name: 'mic')
      post_spring = FactoryBot.build(:post, user_id: user_jack.id, season: 0)
      post_summer = FactoryBot.build(:post, user_id: user_jack.id, season: 1)
      post_fall = FactoryBot.build(:post, user_id: user_jack.id, season: 2)
      post_winter = FactoryBot.build(:post, user_id: user_jack.id, season: 3)
    end

    it '季節が春の場合' do
      params = { is_search_category: 'Post', seachdata: 'keyword', is_search_condition: 'condition', is_search_season: 0}
    end
  end
end



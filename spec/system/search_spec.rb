# frozen_string_literal: true
require 'rails_helper'


RSpec.describe Public::SearchesController, type: :controller do
  describe '投稿のテスト' do
    before do
      user_jack = FactoryBot.create(:user, name: 'jack')
      user_mic = FactoryBot.create(:user, name: 'mic')
      @post = FactoryBot.create(:post, user_id: user_jack.id, season: 0)
      FactoryBot.create(:post, user_id: user_jack.id, season: 1)
      FactoryBot.create(:post, user_id: user_jack.id, season: 2)
      FactoryBot.create(:post, user_id: user_jack.id, season: 3)
    end

    it '季節が春の場合' do
      params = { seachdata: '',category: 'Post', condition: 'PartialMatch',season: 0}

      get search_result_path, params: params

      expect(response).to render_template('public/searches/result')
      expect(assigns(:post)).to eq(@post)
      expect(assigns(:post)).to receive(:looks).with('','Post','PartialMatch',0)
    end
  end
end
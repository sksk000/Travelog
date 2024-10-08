# frozen_string_literal: true
# format documentation
require 'rails_helper'


RSpec.describe 'Userのテスト' do
  include Devise::Test::IntegrationHelpers
  include ActionDispatch::Integration::Runner
  before do
    @user = FactoryBot.create(:user)
    sign_in @user
  end

  it "ユーザ登録後にルートページへ遷移できるか" do
    get root_path
    expect(response).to have_http_status(200)
  end

end
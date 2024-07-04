class Admin::UsersController < ApplicationController
  def index
    @userall = User.all
  end
end

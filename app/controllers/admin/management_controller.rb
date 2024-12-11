class Admin::ManagementController < ApplicationController
  def index
    @userall = User.all
    @postall = Post.all
  end
end

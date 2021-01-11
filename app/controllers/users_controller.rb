class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    redirect_to articles_path
  end
end

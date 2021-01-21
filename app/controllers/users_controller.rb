class UsersController < ApplicationController

  before_action :set_user, only: [:edit, :update, :show, :destroy]
  before_action :require_user, except: [:index, :show, :create, :new]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def show
    @articles = @user.articles.paginate(page: params[:page], per_page: 8)
  end

  def new
    @user = User.new
  end

  def index
    @users = User.paginate(page: params[:page], per_page: 8)
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Welcome to Rails Blog, #{@user.user_name}! 🥰 You have successfully signup!"
      redirect_to articles_path
    else
      render 'new'
    end
  end

  def edit

  end

  def update
    if @user.update(user_params)
      flash[:notice] = "Your account was successfully been updated! 🥰"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    @user.destroy
    if current_user.admin?
      flash[:notice] = "User account and all associated data successfully deleted 😅"
      redirect_to users_path
    else
    session[:user_id] = nil
    flash[:notice] = "Account and all associated data successfully deleted 😢"
      redirect_to root_path
    end
  end

  private
  def user_params
    params.require(:user).permit(:user_name, :email, :password)
  end

  def set_user
    @user = User.find(params[:id]);
  end

  def require_same_user
    if current_user != @user && !current_user.admin?
      flash[:alert] = "You are not authorized 🤮"
      redirect_to current_user
    end
  end
end

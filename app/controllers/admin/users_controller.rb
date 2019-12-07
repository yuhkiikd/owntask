class Admin::UsersController < ApplicationController
  before_action :ensure_current_user, only: [:show]
  before_action :set_users, only: [:show, :destroy]

  def index
    @users = User.all
  end

  def new
    if logged_in?
      redirect_to tasks_path
    else
      @user = User.new
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
       session[:user_id] = @user.id
       redirect_to admin_users_path(@user.id)
       flash[:info] = "ようこそ#{@user.name}さん"
    else
      render 'new'
    end
  end

  def destroy
    @user.destroy
    flash[:success] = 'アカウントを削除しました'
    redirect_to admin_users_path
  end

  def show
  end

  private

  def set_users
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def ensure_current_user
    if logged_in? == false
      redirect_to session_path
    elsif current_user.id != params[:id].to_i
      redirect_to tasks_path
    end
  end
end
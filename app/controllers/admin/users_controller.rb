class Admin::UsersController < ApplicationController
  before_action :ensure_current_user, only: [:show, :new, :edit]
  before_action :ensure_admin, only: [:index, :new, :edit, :update, :destroy]
  before_action :set_users, only: [:show, :destroy, :edit, :update]

  def index
    @users = User.all.includes(:tasks)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
       session[:user_id] = @user.id unless current_user
       redirect_to admin_user_path(@user.id)
       flash[:info] = "ようこそ#{@user.name}さん"
    else
      render :new
    end
  end

  def destroy
    @user.destroy
    flash[:success] = 'アカウントを削除しました'
    redirect_to admin_users_path
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path(@user)
      flash[:info] = "ユーザー[ #{@user.name} ]を更新しました"
    else
      render :edit
      flash[:danger] = "ユーザー[ #{@user.name} ]を更新出来ませんでした"
    end
  end

  private

  def set_users
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :admin, :password, :password_confirmation)
  end

  def ensure_current_user
    if logged_in? == false
      redirect_to new_session_path
      flash[:danger] = "ログインしてください"
    elsif current_user.id != params[:id].to_i
      redirect_to tasks_path
      flash[:danger] = "ログイださい"
    end
  end

  def ensure_admin
    unless current_user.admin?
      redirect_to tasks_path
      flash[:danger] = "管理者権限がありません。"
    end
  end
end
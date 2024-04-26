class UserSessionsController < ApplicationController
  before_action :require_login, only: [:destroy]

  def new
  end

  def create
    @user = login(params[:email], params[:password])

    if @user
      flash[:success] = 'ログインしました'
      redirect_back_or_to profile_path
    else
      flash.now[:danger] = 'ログインに失敗しました'
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    reset_session # セッションをクリア
    flash[:notice] = 'ログアウトしました'
    redirect_to login_path
  end
end

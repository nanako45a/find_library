class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: %i[new create]

  def new
    # ログインページを表示
  end

  def create
    @user = login(params[:email], params[:password])

    if @user
      flash[:success] = 'ログインしました'
      redirect_back_or_to profile_path #投稿一覧機能実装したらposts_pathに変更
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

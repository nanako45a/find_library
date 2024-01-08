class ProfilesController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]

  def show
    # プロフィール表示処理
  end

  def edit
    # プロフィール編集画面の処理
  end

  #更新成功でマイページ、失敗で編集画面に戻る
  def update
    if @user.update(user_params)
      redirect_to profile_path
      flash[:success]= 'プロフィールが更新されました'
    else
      flash.now[:danger] = 'プロフィールの編集に失敗しました'
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:email, :name, :avatar, :avatar_cache)
  end
end

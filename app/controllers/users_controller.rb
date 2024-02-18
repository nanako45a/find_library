class UsersController < ApplicationController
  def new
    @user = User.new
  end

  # 新規登録後自動ログイン
  def create
    @user = User.new(user_params)
    if @user.save
      auto_login(@user)
      @user.create_profile
      redirect_to profile_path
      flash[:success]= 'ユーザーを登録しました'
    else
      flash.now[:danger] = 'ユーザーを登録できませんでした'
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :avatar, :user_prefecture, :user_city)
  end
end

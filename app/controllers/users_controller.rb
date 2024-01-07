class UsersController < ApplicationController
  # ログインしていないユーザーでもnew,createアクションにアクセスできるように設定（require_loginフィルターをスキップ）
  skip_before_action :require_login, only: [:new, :create]
 
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to login_path, flash: { success: t('.success') }
    else
      flash.now[:error] = t('.fail')
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name)
  end
end

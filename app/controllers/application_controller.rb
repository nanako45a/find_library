class ApplicationController < ActionController::Base
  private

  # ユーザーがログインしていない場合ログインページへリダイレクト
  def not_authenticated
    redirect_to login_path
  end
end

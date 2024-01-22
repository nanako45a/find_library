class ApplicationController < ActionController::Base
  # ユーザーがログインしているかチェック
  before_action :require_login

  private
  # ユーザーがログインしていない場合ログインページへリダイレクト
  def not_authenticated
    redirect_to login_path
  end
end

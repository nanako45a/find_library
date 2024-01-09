class ApplicationController < ActionController::Base
  # ユーザーがログインしていることを要求
  before_action :require_login

  private

  def not_authenticated
    redirect_to login_path
  end
end

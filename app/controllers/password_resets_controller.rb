class PasswordResetsController < ApplicationController
  # ログイン要求をスキップ
  skip_before_action :require_login

  # パスワードリセット申請画面へレンダリング
  def new; end

  def create
    # 入力されたメールアドレスに基づいてユーザーを検索
    @user = User.find_by(email: params[:email])
    # 該当するユーザーが存在する場合、ユーザーにパスワードリセット申請メールを送信
    @user&.deliver_reset_password_instructions!
    # ログイン画面にリダイレクトし、成功メッセージ表示
    redirect_to login_path
    flash[:success]= 'メールを送信しました'
  end

  # パスワードリセットトークンを使用してパスワードリセットフォームを表示
  def edit
    # URLからリセットトークンIDを取得してユーザーを特定
    @token = params[:id]
    @user = User.load_from_reset_password_token(params[:id])
    # ユーザーが見つからない場合は、not_authenticatedメソッドを呼び出す
    not_authenticated if @user.blank?
  end

  def update
    # URLからリセットトークンIDを取得してユーザーを特定
    @token = params[:id]
    @user = User.load_from_reset_password_token(params[:id])

    # ユーザーが見つからない場合は、not_authenticatedメソッドを呼び出す
    if @user.blank?
      not_authenticated
      return
    end

    # パスワードとその確認を検証しパスワードを変更
    @user.password_confirmation = params[:user][:password_confirmation]
    if @user.change_password(params[:user][:password])
      # 変更成功でログインページへリダイレクトし成功メッセージ表示
      redirect_to login_path
      flash[:success]= 'パスワードがリセットされました'
    else
      # 変更失敗でパスワードリセットフォームへ戻る
      render action: 'edit'
    end
  end
end

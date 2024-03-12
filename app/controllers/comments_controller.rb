class CommentsController < ApplicationController
  # ユーザーがログインしていることを確認
  before_action :require_login

  def create
    # コメントする図書館を特定
    @library = Library.find(params[:library_id])
    # 新しいコメントを直接作成し、パラメーターからlibrary_idを取得して設定
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to @library, notice: 'コメントを追加しました。'
    else
      redirect_to @library, alert: 'コメントの追加に失敗しました。'
    end
  end

  def destroy
    # 削除するコメントと属する図書館を特定
    @comment = Comment.find(params[:id])
    @library = @comment.library
    if @comment.user == current_user
      @comment.destroy
      redirect_to @library, notice: 'コメントを削除しました。'
    else
      redirect_to @library, alert: 'コメントの削除に失敗しました。'
    end
  end

  private

  # Strong Parameters
  # フォームから送信されたデータのうち、許可されたパラメータのみ使用可能にする
  def comment_params
    params.require(:comment).permit(:comments_body, :comments_seats_number, :comments_pc_available, :comments_wifi_available, :comments_power_available, :library_id)
  end
end

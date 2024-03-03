class CommentsController < ApplicationController
  # ユーザーがログインしていることを確認
  before_action :require_login

  def create
    # コメントを追加する図書館を特定
    @library = Library.find(params[:library_id])
    # 特定の図書館に新しいコメントを構築し、現在ログインしているユーザーをコメントユーザーとして設定
    @comment = @library.comments.build(comment_params)
    @comment.user = current_user
    # コメント保存の条件分岐
    if @comment.save
      redirect_to @library, notice: 'コメントを追加しました。'
    else
      redirect_to @library, alert: 'コメントの追加に失敗しました。'
    end
  end

  def destroy
    # 削除するコメントを特定
    @comment = Comment.find(params[:id])
    # コメントが属する図書館を特定
    @library = @comment.library
    # 現在ログイン中のユーザーによって作成された場合のみコメントを削除
    # コメント削除の条件分岐
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
    params.require(:comment).permit(:comments_body, :comments_seats_number, :comments_pc_available, :comments_wifi_available, :comments_power_available)
  end
end  

class BookmarksController < ApplicationController
  # ログインしていることを確認
  before_action :require_login
  # お気に入り登録、解除実行前にset_libraryメソッドを実行するように指定
  before_action :set_library

  # お気に入り登録
  def create
    bookmark = current_user.bookmarks.build(library: @library)
    if bookmark.save
      # 登録成功でライブラリページにリダイレクトし、成功メッセージ表示
      redirect_to @library, notice: 'お気に入りに登録しました'
    else
      # 登録失敗でライブラリページにリダイレクトし、エラーメッセージ表示
      redirect_to @library, alert: 'お気に入りの登録に失敗しました'
    end
  end

  # お気に入り解除
  def destroy
    # ユーザーがお気に入り解除に指定した、登録済みの図書館IDを検索し削除
    bookmark = current_user.bookmarks.find_by(library_id: @library.id)
    if bookmark.destroy
      # 削除成功でライブラリページにリダイレクトし、成功メッセージ表示
      redirect_to @library, notice: 'お気に入りを解除しました'
    else
      # 削除成功でライブラリページにリダイレクトし、エラーメッセージ表示
      redirect_to @library, alert: 'お気に入りの解除に失敗しました'
    end
  end

  private

  def set_library
    @library = Library.find(params[:library_id])
  end
end
  
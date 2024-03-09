class BookmarksController < ApplicationController
  def create
    # Userモデルで定義したbookmarkのメソッドの呼び出し
    @library = Library.find(params[:library_id])
    current_user.bookmark(@library)
  end

  def destroy
    # Userモデルで定義したunbookmarkのメソッドの呼び出し
    @library = current_user.bookmarks.find(params[:id]).library
    current_user.unbookmark(@library)
  end
end

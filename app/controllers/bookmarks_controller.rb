class BookmarksController < ApplicationController
  before_action :set_library, only: [:create, :destroy]

  def create
    bookmark = current_user.bookmarks.build(library: @library)
    if bookmark.save
      redirect_to @library, notice: 'お気に入りに登録しました'
    else
      redirect_to @library, alert: 'お気に入りの登録に失敗しました'
    end
  end

  def destroy
    bookmark = current_user.bookmarks.find_by(library_id: @library.id)
    if bookmark.destroy
      redirect_to @library, notice: 'お気に入りを解除しました'
    else
      redirect_to @library, alert: 'お気に入りの解除に失敗しました'
    end
  end

  private

  def set_library
    @library = Library.find(params[:library_id])
  end
end
  
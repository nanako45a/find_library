class BookmarksController < ApplicationController
  before_action :require_login
  before_action :set_library

  # お気に入り登録
  def create
    bookmark = current_user.bookmarks.build(library: @library)
    if bookmark.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to @library, notice: 'お気に入りに登録しました' }
      end
    else
      redirect_to @library, alert:'お気に入りの登録に失敗しました'
    end
  end

  # お気に入り解除
  def destroy
    bookmark = current_user.bookmarks.find_by(library_id: @library.id)
    if bookmark.destroy
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to @library, notice: 'お気に入りを解除しました' }
      end
    else
      redirect_to @library, alert: 'お気に入りの解除に失敗しました'
    end
  end

  private

  def set_library
    @library = Library.find(params[:library_id])
  end
end
  
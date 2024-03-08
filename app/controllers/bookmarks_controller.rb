class BookmarksController < ApplicationController
  def create
    @library = Library.find(params[:library_id])
    current_user.bookmark(@library)
  end

  def destroy
    @library = current_user.bookmarks.find(params[:id]).library
    current_user.unbookmark(@library)
  end
end

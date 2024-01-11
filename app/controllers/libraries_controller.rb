class LibrariesController < ApplicationController
  def index
    @libraries = Library.all
  end

  def show
    @library = Library.find_by(id: params[:id])
    if @library.nil?
      redirect_to libraries_path, alert: '図書館が見つかりませんでした。'
    end
  end
end

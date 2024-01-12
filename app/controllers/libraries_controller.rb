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

  def new
    @library = Library.new
  end

  def create
    @library = Library.new(library_params)
    if @library.save
      redirect_to @library, notice: '図書館が正常に作成されました。'
    else
      render :new
    end
  end

  def edit
    @library = Library.find(params[:id])
  end

  def update
    @library = Library.find(params[:id])
    if @library.update(library_params)
      redirect_to @library, notice: '図書館情報が更新されました。'
    else
      render :edit
    end
  end

  def destroy
    @library = Library.find(params[:id])
    @library.destroy
    redirect_to libraries_path, notice: '図書館が削除されました。'
  end

  private

# StrongParameters機能（コントローラーはフォームから送信されたパラメータを安全にハンドルしマスアサインメントの脆弱性を防ぐ）
  def library_params
    params.require(:library).permit(:name, :prefecture, :study_rooms, :latitude, :longitude)
  end
end

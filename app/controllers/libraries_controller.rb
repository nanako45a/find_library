class LibrariesController < ApplicationController
  # ログインしていなくても図書館一覧、詳細画面はアクセスできるようにする
  skip_before_action :require_login, only: [:index, :show]

  def index
    @unique_library_names = Library.unique_library_names
    @unique_prefectures = Library.unique_prefectures
    @libraries = Library.search(params[:name], params[:prefecture], params[:study_rooms], params[:holiday])
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
    @library.user = current_user
    if @library.save
      redirect_to @library, notice: '図書館を登録しました'
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
      redirect_to @library, notice: '図書館の情報を更新しました'
    else
      render :edit
    end
  end

  def destroy
    @library = Library.find(params[:id])
    @library.destroy
    redirect_to libraries_path, notice: '図書館を削除しました'
  end

  private

# StrongParameters機能（コントローラーはフォームから送信されたパラメータを安全にハンドルしマスアサインメントの脆弱性を防ぐ）
  def library_params
    params.require(:library).permit(:name, :prefecture, :study_rooms, :body, :address, :access, :img, :holiday)
  end
end

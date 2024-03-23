class LibrariesController < ApplicationController
  # 図書館登録、編集、削除機能実行前にログインしていることを確認
  before_action :require_login, only: [:new, :create, :edit, :update, :destroy]

  def index
    # ransackを使用して検索条件に基づいてフィルタリングされた図書館のリストをページネート
    @q = Library.ransack(params[:q])
    @libraries = @q.result(distinct: true).includes(:user).order(created_at: :desc).page(params[:page])

  end

  def show
    # URLの図書館IDに基づいて図書館データを検索
    @library = Library.find_by(id: params[:id])
    # 図書館が見つからない場合は図書館一覧ページにリダイレクトし、エラーメッセージ表示
    if @library.nil?
      redirect_to libraries_path, alert: '図書館が見つかりませんでした。'
    else
      @comments = @library.comments # 既存のコメントを取得
      @comment = @library.comments.build # 新しいコメント用のオブジェクトをビルド
    end
  end

  def new
    @library = Library.new
  end

  def create
    # 新しい図書館を作成
    @library = Library.new(library_params)
    # 現在のユーザーを投稿者として設定
    @library.user = current_user
    # 投稿成功で、図書館詳細ページにリダイレクトし、成功メッセージ表示
    if @library.save
      redirect_to @library, notice: '図書館を登録しました'
    else
    # 投稿失敗で投稿フォームに戻る
      render :new
    end
  end

  def edit
    # URLの図書館IDに基づいて図書館データを検索
    @library = Library.find(params[:id])
  end

  def update
    # URLの図書館IDに基づいて図書館データを検索
    @library = Library.find(params[:id])
    if @library.update(library_params)
      # 編集成功で図書館詳細画面にリダイレクト
      redirect_to @library, notice: '図書館の情報を更新しました'
    else
      # 編集失敗で、編集フォームに戻る
      render :edit
    end
  end

  def destroy
    # URLの図書館IDに基づいて図書館データを検索
    @library = Library.find(params[:id])
    # 図書館削除で図書館一覧ページへリダイレクトし成功メッセージ表示
    @library.destroy
    redirect_to libraries_path, notice: '図書館を削除しました'
  end

  def search
    @libraries = Library.where("name like ?", "%#{params[:q]}%")
    respond_to do |format|
      format.js
    end
  end

  private

  # StrongParameters機能（コントローラーはフォームから送信されたパラメータを安全にハンドルしマスアサインメントの脆弱性を防ぐ）
  def library_params
    params.require(:library).permit(:name, :prefecture, :study_rooms, :body, :address, :access, :img, :holiday, :latitude, :longitude, :seats_number, :pc_available, :wifi_available, :power_available)
  end
end

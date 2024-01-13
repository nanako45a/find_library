class PostsController < ApplicationController
  # 投稿の一覧を取得
  def index
    @posts = Post.all
  end

  # 特定の投稿を取得
  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  # 新しい投稿のためのフォームを表示
  def new
    @post = Post.new
  end

  # フォームから送信されたデータで新しい投稿を作成
  def create
    @post = Post.new(post_params)
    if @post.save
    redirect_to @post, notice: '投稿が作成されました。'
    else
    render :new
    end
  end

  # 既存の投稿を編集するためのフォームを表示
  def edit
    @post = Post.find(params[:id])
  end

  # 編集フォームから送信されたデータで投稿を更新
  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
    redirect_to @post, notice: '投稿が更新されました。'
    else
    render :edit
    end
  end

  # 特定の投稿を削除
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_url, notice: '投稿が削除されました。'
  end

  private

  # フォームから送信されたデータを安全に扱うためのストロングパラメータを設定
  def post_params
    params.require(:post).permit(:title, :body, :user_id, :library_id)
  end
end

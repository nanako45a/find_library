class ProfilesController < ApplicationController
  before_action :require_login
  before_action :set_user

  def show
    # ユーザーが投稿した図書館を取得
    @libraries = Library.where(user_id: @user.id)
    # ユーザーがブックマークした図書館を取得
    @bookmarked_libraries = @user.bookmarked_libraries

    # ユーザーの緯度経度を取得
    geocode_result = GeocodeService.get_user_geocode(@user.user_prefecture, @user.user_city)
    if geocode_result[:user_latitude] && geocode_result[:user_longitude]
      @nearby_libraries = GeocodeService.find_libraries_nearby(geocode_result[:user_latitude], geocode_result[:user_longitude])
    else
      @nearby_libraries = []
    end
  end

  def new
    @profile = Profile.new
  end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to profile_path
      flash[:success]= 'マイページを更新しました'
    else
      flash.now[:danger] = 'マイページを編集できませんでした'
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :avatar, :user_prefecture, :user_city)
  end  

  # ログイン中のユーザー情報を@userに格納
  def set_user
    @user = current_user
  end
end

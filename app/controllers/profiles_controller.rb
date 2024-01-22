class ProfilesController < ApplicationController
  # ユーザー詳細、編集画面にアクセスする前にset_profileとset_userメソッドを呼び出しユーザー情報を取得
  before_action :set_profile, only: [:show, :edit, :update]
  before_action :set_user, only: [:show, :edit, :update]

  def show
    # ユーザーが投稿した図書館を取得
    @libraries = Library.where(user_id: @user.id)
    # ユーザーがブックマークした図書館を取得
    @bookmarked_libraries = @user.bookmarked_libraries
  end

  def new
    @profile = Profile.new
  end

  def edit; end

  # ユーザー登録と同時にマイページは作成されるためcreateアクションは不要かも（削除検討）
  def create
    @profile = Profile.new(profile_params)
    @profile.user = current_user

    if @profile.save  
      redirect_to profile_path
      flash[:success]= 'マイページが作成されました'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # 
  def update
    if @profile.update(profile_params) && @user.update(user_params)
      redirect_to profile_path
      flash[:success]= 'マイページを更新しました'
    else
      flash.now[:danger] = 'マイページを編集できませんでした'
      render :edit, status: :unprocessable_entity
    end
  end

  private

  # ログイン中のユーザー情報を取得し@profileに格納
  def set_profile
    @profile = current_user.profile
  end

  def profile_params
    params.require(:profile).permit(:name, :avatar, :avatar_cache)
  end

  def user_params
    params.require(:profile).require(:user).permit(:email)
  end  

  # ログイン中のユーザー情報を@userに格納
  def set_user
    @user = current_user
  end
end

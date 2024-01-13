class ProfilesController < ApplicationController
  before_action :set_profile, only: [:show, :edit, :update]
  before_action :set_user, only: [:show, :edit, :update]

  def show
    @libraries = Library.where(user_id: @user.id)
  end

  def new
    @profile = Profile.new
  end

  def edit; end

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

  def update
    if @profile.update(profile_params)
      redirect_to profile_path
      flash[:success]= 'マイページを更新しました'
    else
      flash.now[:danger] = 'マイページを編集できませんでした'
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_profile
    @profile = current_user.profile
  end

  def profile_params
    params.require(:profile).permit(:name, :avatar, :avatar_cache)
  end

  def set_user
    @user = current_user
  end
end

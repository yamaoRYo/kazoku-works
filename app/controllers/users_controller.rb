class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[new create]
  before_action :set_user, only: %i[show edit update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save!
      flash[:notice] = "ユーザー登録が完了しました"
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @family = @user.family
  end

  def edit;
  end

  def update
    if @user.update!(detail_params)
      redirect_to @user, flash[:notice] = "ユーザー情報を更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end
  
  def detail_params
    params.require(:user).permit(:relationship, :birthdate, :age, :constellation, :blood_type, :image)
  end
end

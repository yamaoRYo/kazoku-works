class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[new create]
  before_action :set_user, only: %i[show edit update]
  before_action :authorize_user_family_access, only: %i[show edit update]

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
      flash[:notice] = "ユーザー情報を更新しました"
      redirect_to user_path(@user)
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

  def authorize_user_family_access
    if current_user.family != @user.family
      flash[:alert] = "You are not a member of this family."
      redirect_to families_path
    end
  end
end

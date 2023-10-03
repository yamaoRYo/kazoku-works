class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[new create]
  before_action :set_user, only: %i[show edit update]
  before_action :authorize_user_family_access, only: %i[show edit update] 

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if session[:invitation_token]
      invitation = Invitation.find_by(token: session[:invitation_token])
      if invitation
        @user.family = invitation.family
      end
    end
    if @user.save
      session[:user_id] = @user.id
      redirect_to @user, notice: t('messages.success.create', model_name: User.model_name.human)
    else
      render :new , status: :unprocessable_entity
    end
  end

  def show
    @family = @user.family
  end

  def edit
    if current_user != @user
      flash[:alert] = t('messages.errors.not_found', model_name: User.model_name.human)
      redirect_to user_path(@user)
    end
  end

  def destroy_image
    @user = User.find(params[:id])
    @user.image.purge
    redirect_to @user, notice: t('messages.success.delete_image')
  end

  def update
    if @user.update!(detail_params)
      flash.now[:notice] = t('messages.success.update', model_name: User.model_name.human)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def set_user
    @user = User.find_by(id: params[:id])
    unless @user
      flash[:alert] = t('messages.errors.not_found', model_name: User.model_name.human  )
      redirect_to families_path
    end
  end
  
  def detail_params
    params.require(:user).permit(:relationship, :birthdate, :age, :constellation, :blood_type, :image)
  end
end

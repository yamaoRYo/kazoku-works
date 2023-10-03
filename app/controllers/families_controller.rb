class FamiliesController < ApplicationController
  before_action :require_login
  before_action :set_family, only: %i[show edit update]
  before_action :authorize_user_family_access, only: %i[show edit update]

  def index
    if current_user.family.present?
    @family = current_user.family
    else
      redirect_to new_family_path
    end
  end

  def new
    if current_user.family.present?
      flash[:alert] = t('messages.errors.already_created', model_name: Family.model_name.human)
      redirect_to families_path
    else
      @family = Family.new
      render :new
    end
  end
  
  def create
    @family = Family.new(family_params)
    @family.admin = current_user
    if @family.save
      current_user.family = @family
      current_user.save
      flash[:notice] = t('messages.success.create', model_name: Family.model_name.human)
      redirect_to  family_path(@family)
    else
      render :new, status: :unprocessable_entity
    end
  end
  
  def show; end

  def edit;
  end

  def update
    if @family.update(family_params)
      flash.now[:notice] = t('messages.success.update', model_name: Family.model_name.human)
    else
      render :edit, status: :unprocessable_entity
    end
  end
  

  private

  def family_params
    params.require(:family).permit(:name, :established_date)
  end

  def set_family
    @family = Family.find_by(id: params[:id])
    unless @family
      flash[:alert] = t('messages.errors.not_found', model_name: Family.model_name.human)
      redirect_to families_path
    end
  end
end
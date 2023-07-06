class FamiliesController < ApplicationController
  before_action :require_login
  before_action :set_family, only: %i[show edit update]

  def index
    @family = current_user.family
  end

  def new
    if current_user.family.present?
      flash[:alert] = "You are already a member of a family."
      redirect_to families_path
    else
      @family = Family.new
      render :new
    end
  end
  
  def create
    @family = Family.new(family_params)
    if @family.save
      current_user.family = @family
      current_user.save
      flash[:notice] = "Family created successfully."
      redirect_to families_path(@family)
    else
      render :new, status: :unprocessable_entity
    end
  end
  
  def show; end

  def edit
    if current_user.family != @family
      flash[:alert] = "You are not a member of this family."
      redirect_to families_path
    end
  end

  def update
    if @family.update(family_params)
      flash.now[:notice] = "Family updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end
  

  private

  def family_params
    params.require(:family).permit(:name, :established_date)
  end

  def set_family
    @family = Family.find(params[:id])
  end
end
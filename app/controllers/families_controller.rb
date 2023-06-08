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
    end
  end
  
  def create
    @family = Family.new(family_params)
    if @family.save
      current_user.family = @family
      current_user.save
      flash[:notice] = "Family created successfully."
      redirect_to families_path
    else
      render :new
    end
  end
  
  def show; end

  def edit; end

  def update
    if @family.update(family_params)
      redirect_to families_path
    else
      render :edit
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
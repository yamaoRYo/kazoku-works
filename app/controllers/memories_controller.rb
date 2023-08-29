class MemoriesController < ApplicationController
  def index
    @memories = Memory.all
  end

  def show
    @memory = Memory.find(params[:id])
  end

  def new
    @memory = Memory.new
  end

  def create
    @memory = Memory.new(params[:memory])
    if @memory.save
      redirect_to @memory, notice: "Successfully created memory."
    else
      render :new
    end
  end

  def upate
    @memory = Memory.find(params[:id])
    if @memory.update_attributes(params[:memory])
      redirect_to @memory, notice: "Successfully updated memory."
    else
      render :edit
    end
  end

  def destroy
    @memory = Memory.find(params[:id])
    @memory.destroy
    redirect_to memories_url, notice: "Successfully destroyed memory."
  end

  private

  def memory_params
    params.require(:memory).permit(:title, :description, :event_id, photos: [])
  end
end

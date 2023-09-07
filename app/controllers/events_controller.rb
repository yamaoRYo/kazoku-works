class EventsController < ApplicationController
  before_action :require_login
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user_family_access, only: %i[show edit update ]

  def new
    @event = Event.new
  end

  def create
    event = Event.new(event_params)
    event.user_id = current_user.id
    if event.save
      flash[:notice] = 'Event was successfully created.'
      redirect_to event
    else
      render :new, status: :unprocessable_entity
    end
  end
  
  def show
    unless @event.visible_to(current_user) && User.find(@event.user_id).family == current_user.family
      flash[:alert] = 'アクセス権限がありません'
      redirect_to families_path
    end
  end
  
  def edit
    unless User.find(@event.user_id).family == current_user.family
      flash[:alert] = 'アクセス権限がありません'
      redirect_to families_path
    end
  end
  

  def index
    @events = Event.all.select do |event|
      event.visible_to(current_user) && User.find(event.user_id).family == current_user.family
    end
  end

  def update
    if @event.update(event_params)
      redirect_to @event, notice: 'Event was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @event.destroy
    flash[:notice] = 'Event was successfully destroyed.'
    redirect_to events_path
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:event_type, :title, :start_date, :end_date, :content, :visibility, visible_to_user_ids: [])
  end
end

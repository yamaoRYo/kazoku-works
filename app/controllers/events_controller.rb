class EventsController < ApplicationController
  before_action :require_login
  before_action :set_event, only: %i[show edit update destroy]
  before_action :authorize_user_family_access, only: %i[show edit update destroy]

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
  
  def show;
  end
  
  def edit;
  end
  

  def index
    @events = Event.visible_to(current_user)
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
    @event = Event.find_by(id: params[:id])
    unless @event
      flash[:alert] = '指定されたイベントは存在しません。'
      redirect_to events_path
    end
  end
  
  

  def event_params
    params.require(:event).permit(:event_type, :title, :start_date, :end_date, :content, :visibility, visible_to_user_ids: [])
  end
end

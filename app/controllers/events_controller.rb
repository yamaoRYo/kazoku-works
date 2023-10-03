class EventsController < ApplicationController
  before_action :require_login
  before_action :set_event, only: %i[show edit update destroy]
  before_action :authorize_event_access, only: %i[show edit update destroy]

  def new
    @event = Event.new
  end

  def create
    event = Event.new(event_params)
    event.user_id = current_user.id
    if event.save
      flash[:notice] = t('messages.success.create', model_name: Event.model_name.human)
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
      redirect_to @event, notice: t('messages.success.update', model_name: Event.model_name.human)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @event.destroy
    @events = Event.visible_to(current_user)
    flash.now[:notice] = t('messages.success.destroy', model_name: Event.model_name.human)
  end  

  private

  def set_event
    @event = Event.find_by(id: params[:id])
    unless @event
      flash[:alert] = t('messages.errors.not_found', model_name: Event.model_name.human)
      redirect_to events_path
    end
  end
  
  

  def event_params
    params.require(:event).permit(:event_type, :title, :start_date, :end_date, :content, :visibility, visible_to_user_ids: [])
  end
end

def authorize_event_access
  if !@event.visible_to(current_user)
    flash[:alert] = t('messages.errors.no_access')
    redirect_to events_path
    return
  end

  unless User.find(@event.user_id).family == current_user.family
    flash[:alert] = t('messages.errors.no_access')
    redirect_to events_path
    return
  end
end

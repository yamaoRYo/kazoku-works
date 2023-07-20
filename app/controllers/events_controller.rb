class EventsController < ApplicationController
  before_action :require_login
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user_family_access, only: %i[show edit update ]

  def new
    @event = Event.new
  end

  def create
    event = Event.new(event_params)
    event.user = current_user
    if event.save
      flash[:notice] = 'Event was successfully created.'
      redirect_to event
    else
      render :new, status: :unprocessable_entity
    end
  end


  def show
    unless @event.user.family == current_user.family
      flash[:alert] = 'アクセス権限がありません'
      redirect_to families_path
    end
  end

  def edit
    unless @event.user.family == current_user.family
      flash[:alert] = 'アクセス権限がありません'
      redirect_to families_path
    end
  end

  def index
    @events = Event.where(user: current_user.family.users)
  end

  def update
    if @event.update(event_params)
      flash[:notice] = 'Event was successfully updated.'
      redirect_to event_path(@event)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @event.destroy
    redirect_to events_url, notice: 'Event was successfully destroyed.'
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:event_type, :title, :start_date, :end_date, :content, :visibility)
  end
end

class EventsController < ApplicationController
  before_action :require_login
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user_family_access, only: %i[show edit update]

  def new
    @event = Event.new
  end

  def create
    @event = current_user.events.build(event_params)
    if @event.save
      redirect_to @event, notice: 'Event was successfully created.'
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @event.update(event_params)
      redirect_to @event, notice: 'Event was successfully updated.'
    else
      render :edit
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

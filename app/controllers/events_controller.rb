class EventsController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  # /
  def index
    @past_events = Event.where('event_date < ?', Date.today).order(event_date: :desc)
    @future_events = Event.where('event_date > ?', Date.today).order(event_date: :asc)
  end
  # /events/new
  def new
    @event = Event.new
  end
  # /events/:id
  def show
    @event = Event.find(params[:id])
  end
  # /events/:id/edit
  def edit
    @event = Event.find(params[:id])
  end
  # /events/:id
  def update
    @event = Event.find(params[:id])
    respond_to do |format|
      if @event.update(event_params)
        format.html {redirect_to root_path, notice: "Event updated successfully"}
      else
        format.html {render 'new', status: :unprocessable_entity }
      end
    end
  end

  # /events/:id
  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to root_path, notice: "Event deleted successfully"
  end
  # /events/
  def create
    @event = current_user.events.build(event_params)
    respond_to do |format|
      if @event.save
        @event.attendees << current_user
        format.html {redirect_to root_path, notice: "Event created successfully"}
      else
        format.html {render 'new', status: :unprocessable_entity }
      end
    end
  end

  private
  def event_params
    params.require(:event).permit(:title, :location, :description, :event_date)
  end

end

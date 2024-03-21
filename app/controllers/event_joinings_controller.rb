class EventJoiningsController < ApplicationController
  before_action :authenticate_user!
  def create
    @event_joining = current_user.event_joinings.build(
      event_id: params[:event_id])
    if @event_joining.save
      redirect_to event_path(params[:event_id]), notice: 'You have successfully joined the event.'
    else
      redirect_to event_path(params[:event_id]), alert: 'There was error joining the event.'
    end
  end
  def destroy
    @event_joining = EventJoining.find_by(user_id: current_user.id, event_id: params[:event_id])
    if @event_joining.destroy
      redirect_to event_path(params[:event_id]), notice: 'You have successfully left the event.'
    else
      redirect_to event_path(params[:event_id]), alert: 'There was an error leaving the event.'
    end
  end
end

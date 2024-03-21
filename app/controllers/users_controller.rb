class UsersController < ApplicationController
  def index
    @past_hosted_events = current_user.events.where('event_date < ?', Date.today).order(event_date: :desc)
    @future_hosted_events = current_user.events.where('event_date > ?', Date.today).order(event_date: :asc)
    @past_attended_events = current_user.joined_events.where('event_date < ?', Date.today).order(event_date: :desc)
    @future_attended_events = current_user.joined_events.where('event_date > ?', Date.today).order(event_date: :asc)
  end
end

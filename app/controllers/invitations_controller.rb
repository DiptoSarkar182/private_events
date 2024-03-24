class InvitationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_invitation, only: [:accept, :reject]

  def index
    @invitations = current_user.received_invitations
  end
  def create
    @invitee = User.find_by(email: params[:email])
    if @invitee
      @event = Event.find(params[:event_id])
      if @invitee == current_user
        redirect_to @event, alert: 'Sending invite to yourself, really?'
      elsif @event.attendees.exists?(@invitee.id)
        redirect_to @event, alert: 'Cannot send invite because user already joined the event.'
      elsif Invitation.pending.exists?(event_id: params[:event_id], inviter: current_user, invitee: @invitee)
        redirect_to @event, alert: 'You have already sent an invitation. Wait for response.'
      else
        @invitation = Invitation.new(event_id: params[:event_id], inviter: current_user, invitee: @invitee)
        if @invitation.save
          redirect_to @invitation.event, notice: 'Invitation created.'
        else
          redirect_to @invitation.event, alert: 'There was an error creating the invitation.'
        end
      end
    else
      redirect_to Event.find(params[:event_id]), alert: 'User not found.'
    end
  end

  def accept
    @invitation.accepted!
    @invitation.destroy
    @invitation.event.attendees << current_user
    redirect_to invitations_path, notice: 'Invitation accepted.'
  end

  def reject
    @invitation.rejected!
    @invitation.destroy
    redirect_to invitations_path, notice: 'Invitation rejected.'
  end

  private

  def set_invitation
    @invitation = Invitation.find(params[:id])
  end
end

class ApplicationController < ActionController::Base
  before_action :set_invitations_counter

  private

  def set_invitations_counter
    @invitations_counter = current_user.received_invitations.count if user_signed_in?
  end
end

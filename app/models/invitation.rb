class Invitation < ApplicationRecord
  belongs_to :event
  belongs_to :inviter, class_name: 'User'
  belongs_to :invitee, class_name: 'User'

  enum status: { pending: 'pending', accepted: 'accepted', rejected: 'rejected' }
end

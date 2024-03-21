class Event < ApplicationRecord

  belongs_to :user
  has_many :event_joinings, dependent: :destroy
  has_many :attendees, through: :event_joinings, source: :user
  has_many :invitations, dependent: :destroy
end

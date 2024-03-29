class Event < ApplicationRecord

  belongs_to :user
  has_many :event_joinings, dependent: :destroy
  has_many :attendees, through: :event_joinings, source: :user
  has_many :invitations, dependent: :destroy

  validates :title, presence: true, length: { maximum: 100 }
  validates :location, presence: true
  validates :event_date, presence: true
  validates :description, length: { maximum: 500 }, presence:true
end

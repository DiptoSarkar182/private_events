class Event < ApplicationRecord
  before_update :remove_past_attendees

  belongs_to :user
  has_many :event_joinings, dependent: :destroy
  has_many :attendees, through: :event_joinings, source: :user
  has_many :invitations, dependent: :destroy

  validates :title, presence: true, length: { maximum: 100 }
  validates :location, presence: true
  validates :event_date, presence: true
  validates :description, length: { maximum: 500 }, presence:true

  # removing past attendees
  private
  def remove_past_attendees
    if event_date_was < Date.today
      event_joinings.where.not(user_id: user_id).destroy_all
    end
  end
end

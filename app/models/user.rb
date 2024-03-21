class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def full_name
    "#{first_name} #{last_name}"
  end
  has_many :events, dependent: :destroy
  has_many :event_joinings
  has_many :joined_events, through: :event_joinings, source: :event
  has_many :sent_invitations, class_name: 'Invitation', foreign_key: 'inviter_id'
  has_many :received_invitations, class_name: 'Invitation', foreign_key: 'invitee_id'
end

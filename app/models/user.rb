class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable

  def full_name
    "#{first_name} #{last_name}"
  end
  has_many :events, dependent: :destroy
  has_many :event_joinings
  has_many :joined_events, through: :event_joinings, source: :event
  has_many :sent_invitations, class_name: 'Invitation', foreign_key: 'inviter_id'
  has_many :received_invitations, class_name: 'Invitation', foreign_key: 'invitee_id'

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_initialize do |user|
      user.provider = auth.provider
      if auth.provider == 'google_oauth2'
        full_name = auth.info.name.split
        user.first_name = full_name[0]
        user.last_name = full_name[1..-1].join(' ')
      end
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      if user.new_record?
        user.save!
      end
    end
  end

end

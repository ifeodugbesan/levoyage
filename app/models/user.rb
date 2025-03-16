class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable
  devise :omniauthable, omniauth_providers: %i[github]
  has_one_attached :avatar
  has_many :issues
  has_many :resources
  has_many :alternatives
  acts_as_voter
  has_many :attempts
  has_many :connections
  has_many :groups

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name   # assuming the user model has a name
      user.nickname = auth.info.nickname   # assuming the user model has a name
      user.image_url = auth.info.image # assuming the user model has an image
      # If you are using confirmable and the provider(s) you use validate emails,
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end

  def latest_connection_is_built?
    connections&.last&.groups&.count == 4
  end

  def signed_in_with_github?
    provider == "github"
  end

  def completed_attempts
    attempts.select { |a| a.completed || a.failed }.size
  end

  def connections_percentage
    @played = completed_attempts
    @wins = attempts.select(&:completed).size
    @wins > 0 ? (@wins / @played.to_f * 100).round : 0
  end

  def current_streak

  end

  def max_streak

  end
end

class User < ApplicationRecord
  has_many :characters, dependent: :destroy
  has_many :chats, dependent: :destroy

  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable,
  # for Google OmniAuth
  :omniauthable, omniauth_providers: [:google_oauth2]

#   def self.from_omniauth(auth)
#     # Find or create a user based on the provider and uid
#     where(provider: auth.provider, uid: auth.uid).first_or_initialize do |user|
#       user.email = auth.info.email
#       user.password = Devise.friendly_token[0, 20] # Generate a random password
#     end
#   end
# end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_initialize do |user|
      user.email      = auth.info.email
      user.password   = Devise.friendly_token[0, 20]
      user.avatar_url = auth.info.image
    end.tap(&:save!)
  end
end

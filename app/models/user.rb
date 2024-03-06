class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    has_many :applications

    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :validatable,
           :omniauthable, omniauth_providers: [:google_oauth2]

    def self.from_omniauth(auth)
     where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
       user.email = auth.info.email
       user.password = Devise.friendly_token[0,20]
       user.fullname = auth.info.name
       user.avatar_url = auth.info.image
       user.id_token = auth.extra.id_token
       user.access_token = auth.credentials.token
       user.refresh_token = auth.credentials.refresh_token
    end
  end

  def update_access_token(auth)
    self.access_token = auth.credentials.token
    self.save
  end
end

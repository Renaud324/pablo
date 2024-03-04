class User < ApplicationRecord
  has_many :applications
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end

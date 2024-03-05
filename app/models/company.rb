class Company < ApplicationRecord
  has_many :contacts
  has_many :interactions
end

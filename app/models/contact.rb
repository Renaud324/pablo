class Contact < ApplicationRecord
  belongs_to :company
  has_many :interaction_contacts
  has_many :interactions, through: :interaction_contacts
end

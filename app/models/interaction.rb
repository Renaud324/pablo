class Interaction < ApplicationRecord
  enum interaction_type: { email: 0, phone: 1, f2f: 2, text: 3, social: 4 }
  belongs_to :user
  belongs_to :job_application
  has_many :interaction_contacts
  has_many :contacts, through: :interaction_contacts

end

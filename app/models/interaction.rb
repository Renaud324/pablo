class Interaction < ApplicationRecord
  enum interaction_type: { Email: 0, Phonecall: 1, "Face-to-face": 2, text: 3, Social: 4, Videocall: 5}
  belongs_to :user
  belongs_to :job_application
  has_many :interaction_contacts
  has_many :contacts, through: :interaction_contacts

  validates :event_date, presence: true
  validates :headline, presence: true
  validates :job_application, presence: true
  validates :interaction_type, presence: true  
end

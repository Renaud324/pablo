class JobApplication < ApplicationRecord
  enum status: { just_applied: 0, first_interview: 1, advanced: 2, offer: 3 }
  belongs_to :user
  belongs_to :company
  has_many :tasks
  has_many :interactions
end

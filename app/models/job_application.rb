class JobApplication < ApplicationRecord
  belongs_to :user
  belongs_to :company
  has_many :tasks
  has_many :interactions
end

class InteractionContact < ApplicationRecord
  belongs_to :contact
  belongs_to :interaction
end

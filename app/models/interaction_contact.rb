class InteractionContact < ApplicationRecord
  belongs_to :contact
  belongs_to :interaction

  def contact_email
    contact.email
  end

end

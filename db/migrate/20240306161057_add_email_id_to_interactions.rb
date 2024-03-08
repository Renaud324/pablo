class AddEmailIdToInteractions < ActiveRecord::Migration[7.1]
  def change
    add_column :interactions, :email_id, :string
  end
end

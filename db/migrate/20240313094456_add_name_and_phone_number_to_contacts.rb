class AddNameAndPhoneNumberToContacts < ActiveRecord::Migration[7.1]
  def change
    add_column :contacts, :name, :string
  end
end

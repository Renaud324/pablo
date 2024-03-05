class AddAccesTokenToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :access_token, :string
  end
end

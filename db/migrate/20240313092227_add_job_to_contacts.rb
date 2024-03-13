class AddJobToContacts < ActiveRecord::Migration[7.1]
  def change
    add_column :contacts, :job_title, :string
  end
end

class DropApplications < ActiveRecord::Migration[7.1]
  def change
    drop_table :applications
  end
end

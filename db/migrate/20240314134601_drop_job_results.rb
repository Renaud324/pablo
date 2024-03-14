class DropJobResults < ActiveRecord::Migration[7.1]
    def up
    drop_table :job_results
  end

  def down
    create_table :job_results do |t|
      t.string :job_id
      t.integer :user_id
      t.string :status
      t.json :result
      t.timestamps
    end
  end
end

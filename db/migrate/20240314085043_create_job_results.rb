class CreateJobResults < ActiveRecord::Migration[7.1]
  def change
    create_table :job_results do |t|
      t.string :job_id
      t.integer :user_id
      t.string :status
      t.text :result

      t.timestamps
    end
  end
end

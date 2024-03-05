class CreateTasks < ActiveRecord::Migration[7.1]
  def change
    create_table :tasks do |t|
      t.string :name
      t.string :description
      t.date :deadline_date
      t.integer :status
      t.date :completion_date
      t.references :job_application, null: false, foreign_key: true

      t.timestamps
    end
  end
end

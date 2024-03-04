class CreateInteractions < ActiveRecord::Migration[7.1]
  def change
    create_table :interactions do |t|
      t.string :headline
      t.date :event_date
      t.time :event_time
      t.string :location
      t.integer :interaction_type
      t.references :user, null: false, foreign_key: true
      t.references :job_application, null: false, foreign_key: true

      t.timestamps
    end
  end
end

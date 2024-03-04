class CreateApplications < ActiveRecord::Migration[7.1]
  def change
    create_table :applications do |t|
      t.datetime :application_start_date
      t.string :job_title
      t.string :offer_link
      t.string :status
      t.string :job_location
      t.text :notes
      t.text :job_description
      t.decimal :salary
      t.string :application_source
      t.references :user, null: false, foreign_key: true
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end
  end
end

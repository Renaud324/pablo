class CreateInteractionContacts < ActiveRecord::Migration[7.1]
  def change
    create_table :interaction_contacts do |t|
      t.references :contact, null: false, foreign_key: true
      t.references :interaction, null: false, foreign_key: true

      t.timestamps
    end
  end
end

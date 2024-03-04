class CreateCompanies < ActiveRecord::Migration[7.1]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :company_link

      t.timestamps
    end
  end
end

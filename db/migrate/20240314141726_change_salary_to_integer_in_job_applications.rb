class ChangeSalaryToIntegerInJobApplications < ActiveRecord::Migration[7.1]
  def change
    change_column :job_applications, :salary, :integer
  end
end

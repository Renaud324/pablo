class ChangeStatusTypeInJobApplications < ActiveRecord::Migration[7.1]
  def up
    change_column :job_applications, :status, 'integer USING CAST(status AS integer)'
  end

  def down
    change_column :job_applications, :status, :string
  end
end

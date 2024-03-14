class ChangeResultToJsonInJobResults < ActiveRecord::Migration[7.1]
    def up
    # Explicitly cast the 'result' column to json
    change_column :job_results, :result, 'json USING CAST(result AS json)'
  end
end

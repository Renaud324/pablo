class Task < ApplicationRecord
  enum status: { pending: 0, in_progress: 1, completed: 2, cancelled: 3, overdue: 4 }
  belongs_to :job_application
end

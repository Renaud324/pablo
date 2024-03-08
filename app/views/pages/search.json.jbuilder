json.tasks_html render(partial: "shared/tasks", formats: :html, locals: { tasks: Task.where(job_application: @job_applications) })
json.list_html render(partial: "job_applications/pipeline", formats: :html, locals: { just_applied_applications: @just_applied_applications,
                                                                                      first_interview_applications: @first_interview_applications,
                                                                                      advanced_process_applications: @advanced_process_applications,
                                                                                      offer_process_applications: @offer_process_applications })

class PagesController < ApplicationController
  def home
    if current_user.present? == false
      return;
    end
    @job_applications = JobApplication.where(user_id: current_user.id)
    @tasks = Task.where(job_application_id: @job_applications.ids)
    @task = Task.new
    @just_applied_applications = JobApplication.where(status: 'Just Applied')
    @first_interview_applications = JobApplication.where(status: 'First Interview')
    @advanced_process_applications = JobApplication.where(status: 'Advanced Process')
    @interactions = Interaction.where(user_id: current_user.id)
  end
end

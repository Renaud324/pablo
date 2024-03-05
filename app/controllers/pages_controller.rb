class PagesController < ApplicationController
  def home
    @job_applications = JobApplication.where(user_id: current_user.id)
    @tasks = Task.where(job_application_id: @job_applications.ids)
  end
end

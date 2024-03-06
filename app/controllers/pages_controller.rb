class PagesController < ApplicationController
  def home
    if current_user.present? == false
      return;
    end
    @job_applications = JobApplication.where(user_id: current_user.id)
    @tasks = Task.where(job_application_id: @job_applications.ids)
    @task = Task.new
  end
end

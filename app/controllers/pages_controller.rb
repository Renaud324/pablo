class PagesController < ApplicationController
  def home
    return unless current_user
    @job_applications = JobApplication.where(user_id: current_user.id)
    @tasks = Task.where(job_application_id: @job_applications.ids)
    @just_applied_applications = @job_applications.where(status: 'Just Applied')
    @first_interview_applications = @job_applications.where(status: 'First Interview')
    @advanced_process_applications = @job_applications.where(status: 'Advanced Process')
    @offer_process_applications = @job_applications.where(status: 'offer')
    @task = Task.new
    @interactions = Interaction.where(user_id: current_user.id)
    
  end

  def search
    @job_applications = JobApplication.where(user_id: current_user.id)

    # search query that allows to search via job title, tasks and company names
    if params[:query].present?
      @job_applications = @job_applications.joins(:company, tasks: []).where("
        job_applications.job_title ILIKE :query OR
        job_applications.job_description ILIKE :query OR
        tasks.name ILIKE :query OR
        companies.name ILIKE :query
      ", query: "%#{params[:query]}%").distinct
    end


    @just_applied_applications = @job_applications.where(status: 'Just Applied')
    @first_interview_applications = @job_applications.where(status: 'First Interview')
    @advanced_process_applications = @job_applications.where(status: 'Advanced Process')
    @offer_process_applications = @job_applications.where(status: 'offer')
    @tasks = Task.where(job_application_id: @job_applications.ids)
    @task = Task.new
    @interactions = Interaction.where(user_id: current_user.id)

  end
end

class PagesController < ApplicationController
  def home
    return unless current_user
    @job_applications = JobApplication.where(user_id: current_user.id)
    @tasks = Task.where(job_application_id: @job_applications.ids).order(created_at: :desc)
    @just_applied_applications = JobApplication.where(status: :just_applied)
    @first_interview_applications = JobApplication.where(status: :first_interview)
    @advanced_process_applications = JobApplication.where(status: :advanced)
    @offer_applications = JobApplication.where(status: :offer)
    @task = Task.new
    @interactions = Interaction.where(user_id: current_user.id)
    @upcoming_interactions = @interactions.where("event_date >= ?", Date.today)

    job_result = JobResult.find_by(job_id: params[:job_id])
    if job_result
      render json: { status: job_result.status, result: job_result.result }
    else
      render json: { status: 'pending' }, status: :not_found
    end

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


    @just_applied_applications = JobApplication.where(status: :just_applied)
    @first_interview_applications = JobApplication.where(status: :first_interview)
    @advanced_process_applications = JobApplication.where(status: :advanced)
    @offer_applications = JobApplication.where(status: :offer)
    @tasks = Task.where(job_application_id: @job_applications.ids)
    @task = Task.new
    @interactions = Interaction.where(user_id: current_user.id)

  end
end

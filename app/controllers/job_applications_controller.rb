class JobApplicationsController < ApplicationController
  before_action :set_job_application, only: %i[show edit update]

  def index
    @job_applications = JobApplication.all
    @just_applied_applications = JobApplication.where(status: 'Just Applied')
    @first_interview_applications = JobApplication.where(status: 'First Interview')
    @advanced_process_applications = JobApplication.where(status: 'Advanced Process')
    @offer_applications = JobApplication.where(status: 'Offer')
    @tasks = Task.where(job_application_id: params[:id])
  end

  def refresh
    GmailJob.perform_later(current_user)
    redirect_to job_applications_path, notice: 'Refresh in progress. Please wait a moment for changes to reflect.'
  end

  def show
    @interaction = Interaction.new
    @interactions = Interaction.where(job_application_id: params[:id])
  end

  def new
    @job_application = JobApplication.new
  end

  def create
    @job_application = JobApplication.new(job_application_params)

    if @job_application.save
      redirect_to @job_application, notice: 'Job application was successfully created.'
    else
      render :new
    end

  end

  def edit
  end

  def update
    if @job_application.update(job_application_params)
      respond_to do |format|
        format.html { redirect_to @job_application, notice: 'Job application was successfully updated.' }
        format.json { render json: { notes: render_to_string(partial: 'notes', locals: { job_application: @job_application }, formats: [:html]) }, status: :ok }
      end
    else
      render :edit
    end
  end

  private

  def set_job_application
    @job_application = JobApplication.find(params[:id])
  end

  def job_application_params
    params.require(:job_application).permit(:application_start_date, :job_title, :offer_link, :status, :job_location, :notes, :job_description, :salary, :application_source, :user_id, :company_id)
  end

  def task_params
    params.require(:task).permit(:name, :description)
  end
end

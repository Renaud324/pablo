class JobApplicationsController < ApplicationController
  before_action :set_job_application, only: %i[show edit update update_status]

  def index
    @job_applications = JobApplication.all

    @just_applied_applications = JobApplication.where(status: :just_applied)
    @first_interview_applications = JobApplication.where(status: :first_interview)
    @advanced_process_applications = JobApplication.where(status: :advanced)
    @offer_applications = JobApplication.where(status: :offer)
    # @tasks = Task.where(job_application_id: params[:id])
    @tasks = Task.all
    # raise

    @job_applications = JobApplication.all

    if params[:query].present?
      sql_subquery = <<~SQL
        job_applications.job_title ILIKE :query
        OR job_applications.job_location ILIKE :query
        OR companies.name ILIKE :query
      SQL
      @job_applications = @job_applications.joins(:company).where(sql_subquery, query: "%#{params[:query]}%")
    end


    if params[:query].present?
      sql_subquery = <<~SQL
        tasks.name ILIKE :query
      SQL
      @tasks = @tasks.where(sql_subquery, query: "%#{params[:query]}%")
    end

    @companies = Company.all
    if params[:query].present?
      sql_subquery = <<~SQL
        companies.name ILIKE :query
      SQL
      @companies = @companies.where(sql_subquery, query: "%#{params[:query]}%")
    end

    @contacts = Contact.all
    if params[:query].present?
      sql_subquery = <<~SQL
        contacts.email ILIKE :query
      SQL
      @contacts = @contacts.where(sql_subquery, query: "%#{params[:query]}%")
    end

    @interactions = Interaction.all
    if params[:query].present?
      sql_subquery = <<~SQL
        interactions.headline ILIKE :query
      SQL
      @interactions = @interactions.where(sql_subquery, query: "%#{params[:query]}%")
    end

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

  def update_status
    if @job_application.update(job_application_params)
      redirect_to root_path, notice: 'Status was successfully updated.'
    else
      redirect_to root_path, alert: 'Failed to update status.'
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

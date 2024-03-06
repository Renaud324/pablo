class TasksController < ApplicationController
  before_action :set_job_application, only: [:index, :new, :create]

  def index
    @tasks = @job_application.tasks
  end

  def new
    @task = Task.new
  end

  def create
    @task = @job_application.tasks.build(task_params)
    if @task.save
      redirect_to home, notice: 'Task was successfully created.'
    else
      render :new
    end
  end
  # create
  # 1 recuepre job application de cette task -> @jobapplication where current user id = gna
  # 2 instancie nouvelle task job application id = celle du dessus (selectionne job application dans formulaire)

  private

  def set_job_application
    @job_application = JobApplication.find(params[:job_application_id])
  end

  def task_params
    params.require(:task).permit(:name, :description)
  end
end

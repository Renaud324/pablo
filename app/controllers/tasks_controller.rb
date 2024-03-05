class TasksController < ApplicationController
  def index
    @tasks = Task.where(job_application_id: params[:id])
  end
end

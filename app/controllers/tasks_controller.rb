class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  # create
  # 1 recuepre job application de cette task -> @jobapplication where current user id = gna
  # 2 instancie nouvelle task job application id = celle du dessus (selectionne job application dans formulaire)




  private

  def task_params
    params.require(:task).permit(:name, :description)
  end
end

class InteractionsController < ApplicationController
  def index
    @interactions = Interaction.where(job_application_id: params[:id])
  end
end

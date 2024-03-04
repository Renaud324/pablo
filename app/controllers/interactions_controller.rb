class InteractionsController < ApplicationController
  def index
    @interactions = Interaction.where(application_id: params[:id])
  end
end

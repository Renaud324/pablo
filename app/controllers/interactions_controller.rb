class InteractionsController < ApplicationController
  def index
    @interactions = current_user.interactions
    @interaction = Interaction.new

  end

  def create
    temp_params=interaction_params
    temp_params[:interaction_type] = temp_params[:interaction_type].to_i
    @interaction = Interaction.new(temp_params)
    @interaction.user = current_user

    if @interaction.save
      # redirect_to @interaction, notice: 'Interaction was successfully created.'
      # redirect_to root_path
      redirect_to interactions_path
    end
  end


  private

  def interaction_params
    params.require(:interaction).permit(:headline, :event_date, :event_time, :location, :interaction_type, :job_application_id)
  end

end

class InteractionsController < ApplicationController
  def index
    @interactions = current_user.interactions
    @interaction = Interaction.new
  end

  def create
    @interaction = Interaction.new(interaction_params)
    @interaction.user = current_user

    if @interaction.save
      redirect_to interactions_path, notice: 'Event was successfully created.'
    else
      render json: {
        html: render_to_string(partial: "interactions/form", locals: { job_application: @interaction.job_application, interaction: @interaction }, formats: [:html])
      }
    end
  end

  def destroy
    @interaction = Interaction.find(params[:id])
    @interaction.destroy
    # render json: { status: :ok }
    redirect_to
  end

  private

  def interaction_params
    params.require(:interaction).permit(:headline, :event_date, :event_time, :location, :interaction_type, :job_application_id)
  end
end

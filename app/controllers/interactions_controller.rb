class InteractionsController < ApplicationController
  def index
    @interactions = current_user.interactions
    @interaction = Interaction.new
  end

  def create
    @interaction = Interaction.new(interaction_params)
    if !params[:interaction][:job_application_id].empty?
      @interaction.job_application = JobApplication.find(params[:interaction][:job_application_id].to_i)
    end
    @interaction.user = current_user
    if @interaction.save
      @interactions = current_user.interactions
      if URI(request.referer).path == "/interactions"
        render json: {
          html: render_to_string(partial: 'interactions/month_calendar', locals: { interactions: @interactions }, formats: [:html]),
          page: :calendar,
          status: :ok,
          form: render_to_string(partial: "interactions/form", locals: { job_application: @interaction.job_application, interaction: Interaction.new }, formats: [:html]) }
      else
        @interaction = Interaction.new
        render json: {
          html: render_to_string(partial: 'job_applications/interactions', formats: [:html]),
          status: :ok }
      end
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

  def send_email
    raise
  end

  private

  def interaction_params
    params.require(:interaction).permit(:headline, :event_date, :event_time, :location, :interaction_type, :job_application_id)
  end
end

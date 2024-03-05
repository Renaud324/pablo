class InteractionsController < ApplicationController
  def index
    @interactions = Interaction.all
    # raise
  end
end

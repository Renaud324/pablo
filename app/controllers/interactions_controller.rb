class InteractionsController < ApplicationController
  def index
    @interactions = Interaction.all
  end
end

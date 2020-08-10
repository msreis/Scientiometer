class ResearcherMultisersController < ApplicationController
  before_action :set_researcher_multiser, only: [:show, :update, :destroy]

  # GET /researcher_multisers
  def index
    @researcher_multisers = ResearcherMultiser.all

    render json: @researcher_multisers
  end

  # GET /researcher_multisers/1
  def show
    render json: @researcher_multiser
  end

  # POST /researcher_multisers
  def create
    @researcher_multiser = ResearcherMultiser.new(researcher_multiser_params)

    if @researcher_multiser.save
      render json: @researcher_multiser, status: :created, location: @researcher_multiser
    else
      render json: @researcher_multiser.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /researcher_multisers/1
  def update
    if @researcher_multiser.update(researcher_multiser_params)
      render json: @researcher_multiser
    else
      render json: @researcher_multiser.errors, status: :unprocessable_entity
    end
  end

  # DELETE /researcher_multisers/1
  def destroy
    @researcher_multiser.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_researcher_multiser
      @researcher_multiser = ResearcherMultiser.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def researcher_multiser_params
      params.permit(:researcher_id, :multiuser_id, :year)
    end
end

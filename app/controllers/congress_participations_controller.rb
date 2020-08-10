class CongressParticipationsController < ApplicationController
  before_action :set_congress_participation, only: [:show, :update, :destroy]

  # GET /congress_participations
  def index
    @congress_participations = CongressParticipation.all

    render json: @congress_participations
  end

  # GET /congress_participations/1
  def show
    render json: @congress_participation
  end

  # POST /congress_participations
  def create
    @congress_participation = CongressParticipation.new(congress_participation_params)

    if @congress_participation.save
      render json: @congress_participation, status: :created, location: @congress_participation
    else
      render json: @congress_participation.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /congress_participations/1
  def update
    if @congress_participation.update(congress_participation_params)
      render json: @congress_participation
    else
      render json: @congress_participation.errors, status: :unprocessable_entity
    end
  end

  # DELETE /congress_participations/1
  def destroy
    @congress_participation.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_congress_participation
      @congress_participation = CongressParticipation.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def congress_participation_params
      params.permit(:researcher_id, :congress_id, :year, :congress_role_id)
    end
end

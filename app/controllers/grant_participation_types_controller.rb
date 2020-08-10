class GrantParticipationTypesController < ApplicationController
  before_action :set_grant_participation_type, only: [:show, :update, :destroy]

  # GET /grant_participation_types
  def index
    @grant_participation_types = GrantParticipationType.all

    render json: @grant_participation_types
  end

  # GET /grant_participation_types/1
  def show
    render json: @grant_participation_type
  end

  # POST /grant_participation_types
  def create
    @grant_participation_type = GrantParticipationType.new(grant_participation_type_params)

    if @grant_participation_type.save
      render json: @grant_participation_type, status: :created, location: @grant_participation_type
    else
      render json: @grant_participation_type.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /grant_participation_types/1
  def update
    if @grant_participation_type.update(grant_participation_type_params)
      render json: @grant_participation_type
    else
      render json: @grant_participation_type.errors, status: :unprocessable_entity
    end
  end

  # DELETE /grant_participation_types/1
  def destroy
    @grant_participation_type.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_grant_participation_type
      @grant_participation_type = GrantParticipationType.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def grant_participation_type_params
      params.permit(:type)
    end
end

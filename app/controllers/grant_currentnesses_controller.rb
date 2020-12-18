class GrantCurrentnessesController < ApplicationController
  before_action :set_grant_currentness, only: [:show, :update, :destroy]

  # GET /grant_currentnesses
  def index
    @grant_currentnesses = GrantCurrentness.all

    render json: @grant_currentnesses
  end

  # GET /grant_currentnesses/1
  def show
    render json: @grant_currentness
  end

  # POST /grant_currentnesses
  def create
    @grant_currentness = GrantCurrentness.new(grant_currentness_params)

    if @grant_currentness.save
      render json: @grant_currentness, status: :created, location: @grant_currentness
    else
      render json: @grant_currentness.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /grant_currentnesses/1
  def update
    if @grant_currentness.update(grant_currentness_params)
      render json: @grant_currentness
    else
      render json: @grant_currentness.errors, status: :unprocessable_entity
    end
  end

  # DELETE /grant_currentnesses/1
  def destroy
    @grant_currentness.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_grant_currentness
      @grant_currentness = GrantCurrentness.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def grant_currentness_params
      params.require(:grant_currentness).permit(:status)
    end
end

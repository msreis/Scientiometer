class CnpqLevelsController < ApplicationController
  before_action :set_cnpq_level, only: [:show, :update, :destroy]

  # GET /cnpq_levels
  def index
    @cnpq_levels = CnpqLevel.all

    render json: @cnpq_levels
  end

  # GET /cnpq_levels/1
  def show
    render json: @cnpq_level
  end

  # POST /cnpq_levels
  def create
    @cnpq_level = CnpqLevel.new(cnpq_level_params)

    if @cnpq_level.save
      render json: @cnpq_level, status: :created, location: @cnpq_level
    else
      render json: @cnpq_level.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /cnpq_levels/1
  def update
    if @cnpq_level.update(cnpq_level_params)
      render json: @cnpq_level
    else
      render json: @cnpq_level.errors, status: :unprocessable_entity
    end
  end

  # DELETE /cnpq_levels/1
  def destroy
    @cnpq_level.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cnpq_level
      @cnpq_level = CnpqLevel.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def cnpq_level_params
      params.permit(:level)
    end
end

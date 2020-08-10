class LaboratoryDivisionsController < ApplicationController
  before_action :set_laboratory_division, only: [:show, :update, :destroy]

  # GET /laboratory_divisions
  def index
    @laboratory_divisions = LaboratoryDivision.all

    render json: @laboratory_divisions
  end

  # GET /laboratory_divisions/1
  def show
    render json: @laboratory_division
  end

  # POST /laboratory_divisions
  def create
    @laboratory_division = LaboratoryDivision.new(laboratory_division_params)

    if @laboratory_division.save
      render json: @laboratory_division, status: :created, location: @laboratory_division
    else
      render json: @laboratory_division.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /laboratory_divisions/1
  def update
    if @laboratory_division.update(laboratory_division_params)
      render json: @laboratory_division
    else
      render json: @laboratory_division.errors, status: :unprocessable_entity
    end
  end

  # DELETE /laboratory_divisions/1
  def destroy
    @laboratory_division.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_laboratory_division
      @laboratory_division = LaboratoryDivision.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def laboratory_division_params
      params.permit(:name)
    end
end

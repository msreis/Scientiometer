class ThesesController < ApplicationController
  before_action :set_thesis, only: [:show, :update, :destroy]

  # GET /theses
  def index
    @theses = Thesis.all

    render json: @theses
  end

  # GET /theses/1
  def show
    render json: @thesis
  end

  # POST /theses
  def create
    @thesis = Thesis.new(thesis_params)

    if @thesis.save
      render json: @thesis, status: :created, location: @thesis
    else
      render json: @thesis.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /theses/1
  def update
    if @thesis.update(thesis_params)
      render json: @thesis
    else
      render json: @thesis.errors, status: :unprocessable_entity
    end
  end

  # DELETE /theses/1
  def destroy
    @thesis.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_thesis
      @thesis = Thesis.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def thesis_params
      params.permit(:finish_year, :institution_id, :delivery_date, :advisement_id)
    end
end

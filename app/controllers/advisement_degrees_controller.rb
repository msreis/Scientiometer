class AdvisementDegreesController < ApplicationController
  before_action :set_advisement_degree, only: [:show, :update, :destroy]

  # GET /advisement_degrees
  def index
    @advisement_degrees = AdvisementDegree.all

    render json: @advisement_degrees
  end

  # GET /advisement_degrees/1
  def show
    render json: @advisement_degree
  end

  # POST /advisement_degrees
  def create
    @advisement_degree = AdvisementDegree.new(advisement_degree_params)

    if @advisement_degree.save
      render json: @advisement_degree, status: :created, location: @advisement_degree
    else
      render json: @advisement_degree.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /advisement_degrees/1
  def update
    if @advisement_degree.update(advisement_degree_params)
      render json: @advisement_degree
    else
      render json: @advisement_degree.errors, status: :unprocessable_entity
    end
  end

  # DELETE /advisement_degrees/1
  def destroy
    @advisement_degree.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_advisement_degree
      @advisement_degree = AdvisementDegree.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def advisement_degree_params
      params.permit(:degree)
    end
end

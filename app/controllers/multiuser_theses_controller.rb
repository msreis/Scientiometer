class MultiuserThesesController < ApplicationController
  before_action :set_multiuser_thesis, only: [:show, :update, :destroy]

  # GET /multiuser_theses
  def index
    @multiuser_theses = MultiuserThesis.all

    render json: @multiuser_theses
  end

  # GET /multiuser_theses/1
  def show
    render json: @multiuser_thesis
  end

  # POST /multiuser_theses
  def create
    @multiuser_thesis = MultiuserThesis.new(multiuser_thesis_params)

    if @multiuser_thesis.save
      render json: @multiuser_thesis, status: :created, location: @multiuser_thesis
    else
      render json: @multiuser_thesis.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /multiuser_theses/1
  def update
    if @multiuser_thesis.update(multiuser_thesis_params)
      render json: @multiuser_thesis
    else
      render json: @multiuser_thesis.errors, status: :unprocessable_entity
    end
  end

  # DELETE /multiuser_theses/1
  def destroy
    @multiuser_thesis.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_multiuser_thesis
      @multiuser_thesis = MultiuserThesis.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def multiuser_thesis_params
      params.permit(:thesis_id, :multiuser_id, :year)
    end
end

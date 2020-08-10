class MultiuserInLabsController < ApplicationController
  before_action :set_multiuser_in_lab, only: [:show, :update, :destroy]

  # GET /multiuser_in_labs
  def index
    @multiuser_in_labs = MultiuserInLab.all

    render json: @multiuser_in_labs
  end

  # GET /multiuser_in_labs/1
  def show
    render json: @multiuser_in_lab
  end

  # POST /multiuser_in_labs
  def create
    @multiuser_in_lab = MultiuserInLab.new(multiuser_in_lab_params)

    if @multiuser_in_lab.save
      render json: @multiuser_in_lab, status: :created, location: @multiuser_in_lab
    else
      render json: @multiuser_in_lab.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /multiuser_in_labs/1
  def update
    if @multiuser_in_lab.update(multiuser_in_lab_params)
      render json: @multiuser_in_lab
    else
      render json: @multiuser_in_lab.errors, status: :unprocessable_entity
    end
  end

  # DELETE /multiuser_in_labs/1
  def destroy
    @multiuser_in_lab.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_multiuser_in_lab
      @multiuser_in_lab = MultiuserInLab.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def multiuser_in_lab_params
      params.permit(:multiuser_id, :laboratory_id, :year)
    end
end

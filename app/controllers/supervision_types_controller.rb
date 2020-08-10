class SupervisionTypesController < ApplicationController
  before_action :set_supervision_type, only: [:show, :update, :destroy]

  # GET /supervision_types
  def index
    @supervision_types = SupervisionType.all

    render json: @supervision_types
  end

  # GET /supervision_types/1
  def show
    render json: @supervision_type
  end

  # POST /supervision_types
  def create
    @supervision_type = SupervisionType.new(supervision_type_params)

    if @supervision_type.save
      render json: @supervision_type, status: :created, location: @supervision_type
    else
      render json: @supervision_type.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /supervision_types/1
  def update
    if @supervision_type.update(supervision_type_params)
      render json: @supervision_type
    else
      render json: @supervision_type.errors, status: :unprocessable_entity
    end
  end

  # DELETE /supervision_types/1
  def destroy
    @supervision_type.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_supervision_type
      @supervision_type = SupervisionType.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def supervision_type_params
      params.permit(:type)
    end
end

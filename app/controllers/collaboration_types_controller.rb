class CollaborationTypesController < ApplicationController
  before_action :set_collaboration_type, only: [:show, :update, :destroy]

  # GET /collaboration_types
  def index
    @collaboration_types = CollaborationType.all

    render json: @collaboration_types
  end

  # GET /collaboration_types/1
  def show
    render json: @collaboration_type
  end

  # POST /collaboration_types
  def create
    @collaboration_type = CollaborationType.new(collaboration_type_params)

    if @collaboration_type.save
      render json: @collaboration_type, status: :created, location: @collaboration_type
    else
      render json: @collaboration_type.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /collaboration_types/1
  def update
    if @collaboration_type.update(collaboration_type_params)
      render json: @collaboration_type
    else
      render json: @collaboration_type.errors, status: :unprocessable_entity
    end
  end

  # DELETE /collaboration_types/1
  def destroy
    @collaboration_type.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_collaboration_type
      @collaboration_type = CollaborationType.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def collaboration_type_params
      params.permit(:type)
    end
end

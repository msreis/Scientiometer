class SubActivityTypesController < ApplicationController
  before_action :set_sub_activity_type, only: [:show, :update, :destroy]

  # GET /sub_activity_types
  def index
    @sub_activity_types = SubActivityType.all

    render json: @sub_activity_types
  end

  # GET /sub_activity_types/1
  def show
    render json: @sub_activity_type
  end

  # POST /sub_activity_types
  def create
    @sub_activity_type = SubActivityType.new(sub_activity_type_params)

    if @sub_activity_type.save
      render json: @sub_activity_type, status: :created, location: @sub_activity_type
    else
      render json: @sub_activity_type.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /sub_activity_types/1
  def update
    if @sub_activity_type.update(sub_activity_type_params)
      render json: @sub_activity_type
    else
      render json: @sub_activity_type.errors, status: :unprocessable_entity
    end
  end

  # DELETE /sub_activity_types/1
  def destroy
    @sub_activity_type.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sub_activity_type
      @sub_activity_type = SubActivityType.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def sub_activity_type_params
      params.require(:sub_activity_type).permit(:name, :activity_type_id)
    end
end

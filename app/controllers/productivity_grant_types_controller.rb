class ProductivityGrantTypesController < ApplicationController
  before_action :set_productivity_grant_type, only: [:show, :update, :destroy]

  # GET /productivity_grant_types
  def index
    @productivity_grant_types = ProductivityGrantType.all

    render json: @productivity_grant_types
  end

  # GET /productivity_grant_types/1
  def show
    render json: @productivity_grant_type
  end

  # POST /productivity_grant_types
  def create
    @productivity_grant_type = ProductivityGrantType.new(productivity_grant_type_params)

    if @productivity_grant_type.save
      render json: @productivity_grant_type, status: :created, location: @productivity_grant_type
    else
      render json: @productivity_grant_type.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /productivity_grant_types/1
  def update
    if @productivity_grant_type.update(productivity_grant_type_params)
      render json: @productivity_grant_type
    else
      render json: @productivity_grant_type.errors, status: :unprocessable_entity
    end
  end

  # DELETE /productivity_grant_types/1
  def destroy
    @productivity_grant_type.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_productivity_grant_type
      @productivity_grant_type = ProductivityGrantType.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def productivity_grant_type_params
      params.require(:productivity_grant_type).permit(:name)
    end
end

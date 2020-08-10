class RoleFoundationLevelsController < ApplicationController
  before_action :set_role_foundation_level, only: [:show, :update, :destroy]

  # GET /role_foundation_levels
  def index
    @role_foundation_levels = RoleFoundationLevel.all

    render json: @role_foundation_levels
  end

  # GET /role_foundation_levels/1
  def show
    render json: @role_foundation_level
  end

  # POST /role_foundation_levels
  def create
    @role_foundation_level = RoleFoundationLevel.new(role_foundation_level_params)

    if @role_foundation_level.save
      render json: @role_foundation_level, status: :created, location: @role_foundation_level
    else
      render json: @role_foundation_level.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /role_foundation_levels/1
  def update
    if @role_foundation_level.update(role_foundation_level_params)
      render json: @role_foundation_level
    else
      render json: @role_foundation_level.errors, status: :unprocessable_entity
    end
  end

  # DELETE /role_foundation_levels/1
  def destroy
    @role_foundation_level.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_role_foundation_level
      @role_foundation_level = RoleFoundationLevel.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def role_foundation_level_params
      params.permit(:description)
    end
end

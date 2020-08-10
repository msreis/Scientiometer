class GrantProjectTypesController < ApplicationController
  before_action :set_grant_project_type, only: [:show, :update, :destroy]

  # GET /grant_project_types
  def index
    @grant_project_types = GrantProjectType.all

    render json: @grant_project_types
  end

  # GET /grant_project_types/1
  def show
    render json: @grant_project_type
  end

  # POST /grant_project_types
  def create
    @grant_project_type = GrantProjectType.new(grant_project_type_params)

    if @grant_project_type.save
      render json: @grant_project_type, status: :created, location: @grant_project_type
    else
      render json: @grant_project_type.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /grant_project_types/1
  def update
    if @grant_project_type.update(grant_project_type_params)
      render json: @grant_project_type
    else
      render json: @grant_project_type.errors, status: :unprocessable_entity
    end
  end

  # DELETE /grant_project_types/1
  def destroy
    @grant_project_type.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_grant_project_type
      @grant_project_type = GrantProjectType.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def grant_project_type_params
      params.permit(:type)
    end
end

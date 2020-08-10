class CongressRolesController < ApplicationController
  before_action :set_congress_role, only: [:show, :update, :destroy]

  # GET /congress_roles
  def index
    @congress_roles = CongressRole.all

    render json: @congress_roles
  end

  # GET /congress_roles/1
  def show
    render json: @congress_role
  end

  # POST /congress_roles
  def create
    @congress_role = CongressRole.new(congress_role_params)

    if @congress_role.save
      render json: @congress_role, status: :created, location: @congress_role
    else
      render json: @congress_role.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /congress_roles/1
  def update
    if @congress_role.update(congress_role_params)
      render json: @congress_role
    else
      render json: @congress_role.errors, status: :unprocessable_entity
    end
  end

  # DELETE /congress_roles/1
  def destroy
    @congress_role.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_congress_role
      @congress_role = CongressRole.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def congress_role_params
      params.permit(:role)
    end
end

class MultiuserGrantsController < ApplicationController
  before_action :set_multiuser_grant, only: [:show, :update, :destroy]

  # GET /multiuser_grants
  def index
    @multiuser_grants = MultiuserGrant.all

    render json: @multiuser_grants
  end

  # GET /multiuser_grants/1
  def show
    render json: @multiuser_grant
  end

  # POST /multiuser_grants
  def create
    @multiuser_grant = MultiuserGrant.new(multiuser_grant_params)

    if @multiuser_grant.save
      render json: @multiuser_grant, status: :created, location: @multiuser_grant
    else
      render json: @multiuser_grant.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /multiuser_grants/1
  def update
    if @multiuser_grant.update(multiuser_grant_params)
      render json: @multiuser_grant
    else
      render json: @multiuser_grant.errors, status: :unprocessable_entity
    end
  end

  # DELETE /multiuser_grants/1
  def destroy
    @multiuser_grant.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_multiuser_grant
      @multiuser_grant = MultiuserGrant.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def multiuser_grant_params
      params.permit(:grant_id, :multiuser_id, :year)
    end
end

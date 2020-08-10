class ProductivityGrantsController < ApplicationController
  before_action :set_productivity_grant, only: [:show, :update, :destroy]

  # GET /productivity_grants
  def index
    @productivity_grants = ProductivityGrant.all

    render json: @productivity_grants
  end

  # GET /productivity_grants/1
  def show
    render json: @productivity_grant
  end

  # POST /productivity_grants
  def create
    @productivity_grant = ProductivityGrant.new(productivity_grant_params)

    if @productivity_grant.save
      render json: @productivity_grant, status: :created, location: @productivity_grant
    else
      render json: @productivity_grant.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /productivity_grants/1
  def update
    if @productivity_grant.update(productivity_grant_params)
      render json: @productivity_grant
    else
      render json: @productivity_grant.errors, status: :unprocessable_entity
    end
  end

  # DELETE /productivity_grants/1
  def destroy
    @productivity_grant.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_productivity_grant
      @productivity_grant = ProductivityGrant.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def productivity_grant_params
      params.permit(:cnpq_level_id, :fb_level_id, :validity_start, :validity_end, :researcher_id, :productivity_scholarship_id)
    end
end

class FundingAgenciesController < ApplicationController
  before_action :set_funding_agency, only: [:show, :update, :destroy]

  # GET /funding_agencies
  def index
    @funding_agencies = FundingAgency.all

    render json: @funding_agencies
  end

  # GET /funding_agencies/1
  def show
    render json: @funding_agency
  end

  # POST /funding_agencies
  def create
    @funding_agency = FundingAgency.new(funding_agency_params)

    if @funding_agency.save
      render json: @funding_agency, status: :created, location: @funding_agency
    else
      render json: @funding_agency.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /funding_agencies/1
  def update
    if @funding_agency.update(funding_agency_params)
      render json: @funding_agency
    else
      render json: @funding_agency.errors, status: :unprocessable_entity
    end
  end

  # DELETE /funding_agencies/1
  def destroy
    @funding_agency.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_funding_agency
      @funding_agency = FundingAgency.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def funding_agency_params
      params.permit(:name)
    end
end

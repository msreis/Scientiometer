class ScholarshipsController < ApplicationController
  before_action :set_scholarship, only: [:show, :update, :destroy]

  # GET /scholarships
  def index
    @scholarships = Scholarship.all

    render json: @scholarships
  end

  # GET /scholarships/1
  def show
    render json: @scholarship
  end

  # POST /scholarships
  def create
    @scholarship = Scholarship.new(scholarship_params)

    if @scholarship.save
      render json: @scholarship, status: :created, location: @scholarship
    else
      render json: @scholarship.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /scholarships/1
  def update
    if @scholarship.update(scholarship_params)
      render json: @scholarship
    else
      render json: @scholarship.errors, status: :unprocessable_entity
    end
  end

  # DELETE /scholarships/1
  def destroy
    @scholarship.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_scholarship
      @scholarship = Scholarship.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def scholarship_params
      params.permit(:advisement_id, :funding_agency_id, :process_number, :total_value_BRL, :total_value_USD, :technical_reserve_BRL, :validity_start, :validity_end)
    end
end

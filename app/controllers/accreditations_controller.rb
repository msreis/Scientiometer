class AccreditationsController < ApplicationController
  before_action :set_accreditation, only: [:show, :update, :destroy]

  # GET /accreditations
  def index
    @accreditations = Accreditation.all

    render json: @accreditations
  end

  # GET /accreditations/1
  def show
    render json: @accreditation
  end

  # POST /accreditations
  def create
    @accreditation = Accreditation.new(accreditation_params)

    if @accreditation.save
      render json: @accreditation, status: :created, location: @accreditation
    else
      render json: @accreditation.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /accreditations/1
  def update
    if @accreditation.update(accreditation_params)
      render json: @accreditation
    else
      render json: @accreditation.errors, status: :unprocessable_entity
    end
  end

  # DELETE /accreditations/1
  def destroy
    @accreditation.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_accreditation
      @accreditation = Accreditation.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def accreditation_params
      params.permit(:researcher_id, :postgraduate_program_id, :institution_id, :year)
    end
end

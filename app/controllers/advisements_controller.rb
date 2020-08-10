# frozen_string_literal: true

class AdvisementsController < ApplicationController
  before_action :authorize_request
  before_action :set_advisement, only: %i[show update destroy]

  # GET /advisements
  def index
    @advisements = Advisement.all

    render json: @advisements
  end

  # GET /advisements/1
  def show
    render json: @advisement
  end

  # POST /advisements
  def create
    @advisement = Advisement.new(advisement_params)

    if @advisement.save
      render json: @advisement, status: :created, location: @advisement
    else
      render json: @advisement.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /advisements/1
  def update
    if @advisement.update(advisement_params)
      render json: @advisement
    else
      render json: @advisement.errors, status: :unprocessable_entity
    end
  end

  # DELETE /advisements/1
  def destroy
    @advisement.destroy
  end

  def advisements_by_researcher
    # we will return an array of hashes like
    # [{adv_id: X, intern_name: XX}, ...]
    advisements = []
    p current_researcher
    found_adv = Advisement.where(researcher_id: current_researcher[:id])
    found_adv.each do |entry|
      hash = {}
      intern = Intern.find(entry[:intern_id])
      degree = AdvisementDegree.find(entry[:advisement_degree_id])
      hash[:id] = entry[:id]
      hash[:name] = intern[:name] + ' - ' + degree[:degree]
      advisements << hash
    end
    render json: advisements
  end

  def current_researcher
    Researcher.find_by(employee_id: @current_account.employee_id)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_advisement
    @advisement = Advisement.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def advisement_params
    params.permit(:advisement_degree_id, :researcher_id, :intern_id, :supervisor_is_postdoc, :validity_start, :validity_end)
  end
end

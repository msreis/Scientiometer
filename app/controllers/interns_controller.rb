# frozen_string_literal: true

require 'time'

class InternsController < ApplicationController
  before_action :set_intern, :authorize_request, only: %i[show update destroy]

  # GET /interns
  def index
    @interns = Intern.all

    render json: @interns
  end

  # GET /interns/1
  def show
    render json: @intern
  end

  # POST /interns
  def create
    @intern = Intern.new(intern_params)

    if @intern.save
      render json: @intern, status: :created, location: @intern
    else
      render json: @intern.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /interns/1
  def update
    if @intern.update(intern_params)
      render json: @intern
    else
      render json: @intern.errors, status: :unprocessable_entity
    end
  end

  # DELETE /interns/1
  def destroy
    @intern.destroy
  end

  def phds
    degree = AdvisementDegree.find_by(degree: 'Doutorado')
    advisements = Advisement.where(advisement_degree_id: degree[:id], validity_start: CurrentYear.current_year..DateTime::Infinity.new)
    ids = advisements.map { |adv| adv[:intern_id] }
    interns = Intern.where(id: ids)
    render json: interns
  end

  def mscs
    degree = AdvisementDegree.find_by(degree: 'Mestrado')
    advisements = Advisement.where(advisement_degree_id: degree[:id], validity_start: CurrentYear.current_year..DateTime::Infinity.new)
    ids = advisements.map { |adv| adv[:intern_id] }
    interns = Intern.where(id: ids)
    render json: interns
  end

  def ics
    degree = AdvisementDegree.find_by(degree: 'Iniciação Científica')
    advisements = Advisement.where(advisement_degree_id: degree[:id], validity_start: CurrentYear.current_year..DateTime::Infinity.new)
    ids = advisements.map { |adv| adv[:intern_id] }
    interns = Intern.where(id: ids)
    render json: interns
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_intern
    @intern = Intern.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def intern_params
    params.permit(:name)
  end
end

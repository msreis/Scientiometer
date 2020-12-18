# frozen_string_literal: true

require 'time'
require 'current_year'

class InternsController < ApplicationController
  before_action :authorize_request

  def current_submission
    if params[:submission]
      Submission.find(params[:submission])
    else
      Submission.find_by(account_id: @current_account[:id],
                         date: CurrentYear.current_year)
    end
  end

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

  def postphds
    degree = AdvisementDegree.find_by(degree: 'Pós-doutorado')
    advisements = Advisement.where(advisement_degree_id: degree[:id], validity_start: CurrentYear.current_year..DateTime::Infinity.new)
    ids = advisements.map { |adv| adv[:intern_id] }
    interns = Intern.where(id: ids, submission_id: current_submission[:id])
    render json: interns
  end

  def phds
    degree = AdvisementDegree.find_by(degree: 'Doutorado')
    advisements = Advisement.where(advisement_degree_id: degree[:id], validity_start: CurrentYear.current_year..DateTime::Infinity.new)
    ids = advisements.map { |adv| adv[:intern_id] }
    interns = Intern.where(id: ids, submission_id: current_submission[:id])
    render json: interns
  end

  def mscs
    degree = AdvisementDegree.find_by(degree: 'Mestrado')
    advisements = Advisement.where(advisement_degree_id: degree[:id], validity_start: CurrentYear.current_year..DateTime::Infinity.new)
    ids = advisements.map { |adv| adv[:intern_id] }
    interns = Intern.where(id: ids, submission_id: current_submission[:id])
    render json: interns
  end

  def ics
    degree = AdvisementDegree.find_by(degree: 'Iniciação Científica')
    advisements = Advisement.where(advisement_degree_id: degree[:id], validity_start: CurrentYear.current_year..DateTime::Infinity.new)
    ids = advisements.map { |adv| adv[:intern_id] }
    interns = Intern.where(id: ids, submission_id: current_submission[:id])
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

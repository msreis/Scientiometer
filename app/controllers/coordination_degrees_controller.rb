class CoordinationDegreesController < ApplicationController
  before_action :set_coordination_degree, only: [:show, :update, :destroy]

  # GET /coordination_degrees
  def index
    @coordination_degrees = CoordinationDegree.all

    render json: @coordination_degrees
  end

  # GET /coordination_degrees/1
  def show
    render json: @coordination_degree
  end

  # POST /coordination_degrees
  def create
    @coordination_degree = CoordinationDegree.new(coordination_degree_params)

    if @coordination_degree.save
      render json: @coordination_degree, status: :created, location: @coordination_degree
    else
      render json: @coordination_degree.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /coordination_degrees/1
  def update
    if @coordination_degree.update(coordination_degree_params)
      render json: @coordination_degree
    else
      render json: @coordination_degree.errors, status: :unprocessable_entity
    end
  end

  # DELETE /coordination_degrees/1
  def destroy
    @coordination_degree.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_coordination_degree
      @coordination_degree = CoordinationDegree.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def coordination_degree_params
      params.require(:coordination_degree).permit(:degree)
    end
end

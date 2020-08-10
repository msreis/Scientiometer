class CourseCoordinationsController < ApplicationController
  before_action :set_course_coordination, only: [:show, :update, :destroy]

  # GET /course_coordinations
  def index
    @course_coordinations = CourseCoordination.all

    render json: @course_coordinations
  end

  # GET /course_coordinations/1
  def show
    render json: @course_coordination
  end

  # POST /course_coordinations
  def create
    @course_coordination = CourseCoordination.new(course_coordination_params)

    if @course_coordination.save
      render json: @course_coordination, status: :created, location: @course_coordination
    else
      render json: @course_coordination.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /course_coordinations/1
  def update
    if @course_coordination.update(course_coordination_params)
      render json: @course_coordination
    else
      render json: @course_coordination.errors, status: :unprocessable_entity
    end
  end

  # DELETE /course_coordinations/1
  def destroy
    @course_coordination.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course_coordination
      @course_coordination = CourseCoordination.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def course_coordination_params
      params.permit(:name, :course_classification_id, :course_degree_id, :workload, :year)
    end
end

class CourseDegreesController < ApplicationController
  before_action :set_course_degree, only: [:show, :update, :destroy]

  # GET /course_degrees
  def index
    @course_degrees = CourseDegree.all

    render json: @course_degrees
  end

  # GET /course_degrees/1
  def show
    render json: @course_degree
  end

  # POST /course_degrees
  def create
    @course_degree = CourseDegree.new(course_degree_params)

    if @course_degree.save
      render json: @course_degree, status: :created, location: @course_degree
    else
      render json: @course_degree.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /course_degrees/1
  def update
    if @course_degree.update(course_degree_params)
      render json: @course_degree
    else
      render json: @course_degree.errors, status: :unprocessable_entity
    end
  end

  # DELETE /course_degrees/1
  def destroy
    @course_degree.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course_degree
      @course_degree = CourseDegree.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def course_degree_params
      params.permit(:degree)
    end
end

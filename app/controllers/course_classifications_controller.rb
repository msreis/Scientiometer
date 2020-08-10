class CourseClassificationsController < ApplicationController
  before_action :set_course_classification, only: [:show, :update, :destroy]

  # GET /course_classifications
  def index
    @course_classifications = CourseClassification.all

    render json: @course_classifications
  end

  # GET /course_classifications/1
  def show
    render json: @course_classification
  end

  # POST /course_classifications
  def create
    @course_classification = CourseClassification.new(course_classification_params)

    if @course_classification.save
      render json: @course_classification, status: :created, location: @course_classification
    else
      render json: @course_classification.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /course_classifications/1
  def update
    if @course_classification.update(course_classification_params)
      render json: @course_classification
    else
      render json: @course_classification.errors, status: :unprocessable_entity
    end
  end

  # DELETE /course_classifications/1
  def destroy
    @course_classification.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course_classification
      @course_classification = CourseClassification.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def course_classification_params
      params.permit(:classification)
    end
end

class StudentPapersController < ApplicationController
  before_action :set_student_paper, only: [:show, :update, :destroy]

  # GET /student_papers
  def index
    @student_papers = StudentPaper.all

    render json: @student_papers
  end

  # GET /student_papers/1
  def show
    render json: @student_paper
  end

  # POST /student_papers
  def create
    @student_paper = StudentPaper.new(student_paper_params)

    if @student_paper.save
      render json: @student_paper, status: :created, location: @student_paper
    else
      render json: @student_paper.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /student_papers/1
  def update
    if @student_paper.update(student_paper_params)
      render json: @student_paper
    else
      render json: @student_paper.errors, status: :unprocessable_entity
    end
  end

  # DELETE /student_papers/1
  def destroy
    @student_paper.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student_paper
      @student_paper = StudentPaper.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def student_paper_params
      params.permit(:article_id, :intern_id, :participation_type_id)
    end
end

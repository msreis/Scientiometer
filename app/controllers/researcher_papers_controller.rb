class ResearcherPapersController < ApplicationController
  before_action :set_researcher_paper, only: [:show, :update, :destroy]

  # GET /researcher_papers
  def index
    @researcher_papers = ResearcherPaper.all

    render json: @researcher_papers
  end

  # GET /researcher_papers/1
  def show
    render json: @researcher_paper
  end

  # POST /researcher_papers
  def create
    @researcher_paper = ResearcherPaper.new(researcher_paper_params)

    if @researcher_paper.save
      render json: @researcher_paper, status: :created, location: @researcher_paper
    else
      render json: @researcher_paper.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /researcher_papers/1
  def update
    if @researcher_paper.update(researcher_paper_params)
      render json: @researcher_paper
    else
      render json: @researcher_paper.errors, status: :unprocessable_entity
    end
  end

  # DELETE /researcher_papers/1
  def destroy
    @researcher_paper.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_researcher_paper
      @researcher_paper = ResearcherPaper.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def researcher_paper_params
      params.permit(:article_id, :researcher_id, :participation_type_id, :first_author, :last_author, :corresponding_author)
    end
end

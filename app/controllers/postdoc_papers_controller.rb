class PostdocPapersController < ApplicationController
  before_action :set_postdoc_paper, only: [:show, :update, :destroy]

  # GET /postdoc_papers
  def index
    @postdoc_papers = PostdocPaper.all

    render json: @postdoc_papers
  end

  # GET /postdoc_papers/1
  def show
    render json: @postdoc_paper
  end

  # POST /postdoc_papers
  def create
    @postdoc_paper = PostdocPaper.new(postdoc_paper_params)

    if @postdoc_paper.save
      render json: @postdoc_paper, status: :created, location: @postdoc_paper
    else
      render json: @postdoc_paper.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /postdoc_papers/1
  def update
    if @postdoc_paper.update(postdoc_paper_params)
      render json: @postdoc_paper
    else
      render json: @postdoc_paper.errors, status: :unprocessable_entity
    end
  end

  # DELETE /postdoc_papers/1
  def destroy
    @postdoc_paper.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_postdoc_paper
      @postdoc_paper = PostdocPaper.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def postdoc_paper_params
      params.require(:postdoc_paper).permit(:postdoc_id, :article_id, :year)
    end
end

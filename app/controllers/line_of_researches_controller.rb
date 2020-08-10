class LineOfResearchesController < ApplicationController
  before_action :set_line_of_research, only: [:show, :update, :destroy]

  # GET /line_of_researches
  def index
    @line_of_researches = LineOfResearch.all

    render json: @line_of_researches
  end

  # GET /line_of_researches/1
  def show
    render json: @line_of_research
  end

  # POST /line_of_researches
  def create
    @line_of_research = LineOfResearch.new(line_of_research_params)

    if @line_of_research.save
      render json: @line_of_research, status: :created, location: @line_of_research
    else
      render json: @line_of_research.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /line_of_researches/1
  def update
    if @line_of_research.update(line_of_research_params)
      render json: @line_of_research
    else
      render json: @line_of_research.errors, status: :unprocessable_entity
    end
  end

  # DELETE /line_of_researches/1
  def destroy
    @line_of_research.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_line_of_research
      @line_of_research = LineOfResearch.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def line_of_research_params
      params.permit(:name)
    end
end

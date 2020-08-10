class ResearcherBooksController < ApplicationController
  before_action :set_researcher_book, only: [:show, :update, :destroy]

  # GET /researcher_books
  def index
    @researcher_books = ResearcherBook.all

    render json: @researcher_books
  end

  # GET /researcher_books/1
  def show
    render json: @researcher_book
  end

  # POST /researcher_books
  def create
    @researcher_book = ResearcherBook.new(researcher_book_params)

    if @researcher_book.save
      render json: @researcher_book, status: :created, location: @researcher_book
    else
      render json: @researcher_book.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /researcher_books/1
  def update
    if @researcher_book.update(researcher_book_params)
      render json: @researcher_book
    else
      render json: @researcher_book.errors, status: :unprocessable_entity
    end
  end

  # DELETE /researcher_books/1
  def destroy
    @researcher_book.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_researcher_book
      @researcher_book = ResearcherBook.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def researcher_book_params
      params.require(:researcher_book).permit(:article_id, :researcher_id, :participation_type_id)
    end
end

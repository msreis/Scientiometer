class PostdocBooksController < ApplicationController
  before_action :set_postdoc_book, only: [:show, :update, :destroy]

  # GET /postdoc_books
  def index
    @postdoc_books = PostdocBook.all

    render json: @postdoc_books
  end

  # GET /postdoc_books/1
  def show
    render json: @postdoc_book
  end

  # POST /postdoc_books
  def create
    @postdoc_book = PostdocBook.new(postdoc_book_params)

    if @postdoc_book.save
      render json: @postdoc_book, status: :created, location: @postdoc_book
    else
      render json: @postdoc_book.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /postdoc_books/1
  def update
    if @postdoc_book.update(postdoc_book_params)
      render json: @postdoc_book
    else
      render json: @postdoc_book.errors, status: :unprocessable_entity
    end
  end

  # DELETE /postdoc_books/1
  def destroy
    @postdoc_book.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_postdoc_book
      @postdoc_book = PostdocBook.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def postdoc_book_params
      params.require(:postdoc_book).permit(:book_id, :postdoc_id, :submission_id, :year)
    end
end

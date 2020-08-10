class StudentBooksController < ApplicationController
  before_action :set_student_book, only: [:show, :update, :destroy]

  # GET /student_books
  def index
    @student_books = StudentBook.all

    render json: @student_books
  end

  # GET /student_books/1
  def show
    render json: @student_book
  end

  # POST /student_books
  def create
    @student_book = StudentBook.new(student_book_params)

    if @student_book.save
      render json: @student_book, status: :created, location: @student_book
    else
      render json: @student_book.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /student_books/1
  def update
    if @student_book.update(student_book_params)
      render json: @student_book
    else
      render json: @student_book.errors, status: :unprocessable_entity
    end
  end

  # DELETE /student_books/1
  def destroy
    @student_book.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student_book
      @student_book = StudentBook.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def student_book_params
      params.require(:student_book).permit(:book_id, :intern_id, :participation_type_id)
    end
end

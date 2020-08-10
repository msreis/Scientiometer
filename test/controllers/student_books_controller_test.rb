require 'test_helper'

class StudentBooksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @student_book = student_books(:one)
  end

  test "should get index" do
    get student_books_url, as: :json
    assert_response :success
  end

  test "should create student_book" do
    assert_difference('StudentBook.count') do
      post student_books_url, params: { student_book: { book_id: @student_book.book_id, intern_id: @student_book.intern_id } }, as: :json
    end

    assert_response 201
  end

  test "should show student_book" do
    get student_book_url(@student_book), as: :json
    assert_response :success
  end

  test "should update student_book" do
    patch student_book_url(@student_book), params: { student_book: { book_id: @student_book.book_id, intern_id: @student_book.intern_id } }, as: :json
    assert_response 200
  end

  test "should destroy student_book" do
    assert_difference('StudentBook.count', -1) do
      delete student_book_url(@student_book), as: :json
    end

    assert_response 204
  end
end

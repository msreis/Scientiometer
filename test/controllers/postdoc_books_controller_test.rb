require 'test_helper'

class PostdocBooksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @postdoc_book = postdoc_books(:one)
  end

  test "should get index" do
    get postdoc_books_url, as: :json
    assert_response :success
  end

  test "should create postdoc_book" do
    assert_difference('PostdocBook.count') do
      post postdoc_books_url, params: { postdoc_book: { book_id: @postdoc_book.book_id, postdoc_id: @postdoc_book.postdoc_id, submission_id: @postdoc_book.submission_id, year: @postdoc_book.year } }, as: :json
    end

    assert_response 201
  end

  test "should show postdoc_book" do
    get postdoc_book_url(@postdoc_book), as: :json
    assert_response :success
  end

  test "should update postdoc_book" do
    patch postdoc_book_url(@postdoc_book), params: { postdoc_book: { book_id: @postdoc_book.book_id, postdoc_id: @postdoc_book.postdoc_id, submission_id: @postdoc_book.submission_id, year: @postdoc_book.year } }, as: :json
    assert_response 200
  end

  test "should destroy postdoc_book" do
    assert_difference('PostdocBook.count', -1) do
      delete postdoc_book_url(@postdoc_book), as: :json
    end

    assert_response 204
  end
end

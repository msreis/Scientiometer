require 'test_helper'

class ResearcherBooksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @researcher_book = researcher_books(:one)
  end

  test "should get index" do
    get researcher_books_url, as: :json
    assert_response :success
  end

  test "should create researcher_book" do
    assert_difference('ResearcherBook.count') do
      post researcher_books_url, params: { researcher_book: { researcher_id: @researcher_book.researcher_id } }, as: :json
    end

    assert_response 201
  end

  test "should show researcher_book" do
    get researcher_book_url(@researcher_book), as: :json
    assert_response :success
  end

  test "should update researcher_book" do
    patch researcher_book_url(@researcher_book), params: { researcher_book: { researcher_id: @researcher_book.researcher_id } }, as: :json
    assert_response 200
  end

  test "should destroy researcher_book" do
    assert_difference('ResearcherBook.count', -1) do
      delete researcher_book_url(@researcher_book), as: :json
    end

    assert_response 204
  end
end

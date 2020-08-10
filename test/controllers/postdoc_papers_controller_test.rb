require 'test_helper'

class PostdocPapersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @postdoc_paper = postdoc_papers(:one)
  end

  test "should get index" do
    get postdoc_papers_url, as: :json
    assert_response :success
  end

  test "should create postdoc_paper" do
    assert_difference('PostdocPaper.count') do
      post postdoc_papers_url, params: { postdoc_paper: { article_id: @postdoc_paper.article_id, postdoc_id: @postdoc_paper.postdoc_id, year: @postdoc_paper.year } }, as: :json
    end

    assert_response 201
  end

  test "should show postdoc_paper" do
    get postdoc_paper_url(@postdoc_paper), as: :json
    assert_response :success
  end

  test "should update postdoc_paper" do
    patch postdoc_paper_url(@postdoc_paper), params: { postdoc_paper: { article_id: @postdoc_paper.article_id, postdoc_id: @postdoc_paper.postdoc_id, year: @postdoc_paper.year } }, as: :json
    assert_response 200
  end

  test "should destroy postdoc_paper" do
    assert_difference('PostdocPaper.count', -1) do
      delete postdoc_paper_url(@postdoc_paper), as: :json
    end

    assert_response 204
  end
end

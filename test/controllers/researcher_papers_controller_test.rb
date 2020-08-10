require 'test_helper'

class ResearcherPapersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @researcher_paper = researcher_papers(:one)
  end

  test "should get index" do
    get researcher_papers_url, as: :json
    assert_response :success
  end

  test "should create researcher_paper" do
    assert_difference('ResearcherPaper.count') do
      post researcher_papers_url, params: { researcher_paper: { article_id: @researcher_paper.article_id, corresponding_author: @researcher_paper.corresponding_author, first_author: @researcher_paper.first_author, last_author: @researcher_paper.last_author, researcher_id: @researcher_paper.researcher_id } }, as: :json
    end

    assert_response 201
  end

  test "should show researcher_paper" do
    get researcher_paper_url(@researcher_paper), as: :json
    assert_response :success
  end

  test "should update researcher_paper" do
    patch researcher_paper_url(@researcher_paper), params: { researcher_paper: { article_id: @researcher_paper.article_id, corresponding_author: @researcher_paper.corresponding_author, first_author: @researcher_paper.first_author, last_author: @researcher_paper.last_author, researcher_id: @researcher_paper.researcher_id } }, as: :json
    assert_response 200
  end

  test "should destroy researcher_paper" do
    assert_difference('ResearcherPaper.count', -1) do
      delete researcher_paper_url(@researcher_paper), as: :json
    end

    assert_response 204
  end
end

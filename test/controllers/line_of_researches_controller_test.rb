require 'test_helper'

class LineOfResearchesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @line_of_research = line_of_researches(:one)
  end

  test "should get index" do
    get line_of_researches_url, as: :json
    assert_response :success
  end

  test "should create line_of_research" do
    assert_difference('LineOfResearch.count') do
      post line_of_researches_url, params: { line_of_research: { name: @line_of_research.name } }, as: :json
    end

    assert_response 201
  end

  test "should show line_of_research" do
    get line_of_research_url(@line_of_research), as: :json
    assert_response :success
  end

  test "should update line_of_research" do
    patch line_of_research_url(@line_of_research), params: { line_of_research: { name: @line_of_research.name } }, as: :json
    assert_response 200
  end

  test "should destroy line_of_research" do
    assert_difference('LineOfResearch.count', -1) do
      delete line_of_research_url(@line_of_research), as: :json
    end

    assert_response 204
  end
end

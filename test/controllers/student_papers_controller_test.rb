require 'test_helper'

class StudentPapersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @student_paper = student_papers(:one)
  end

  test "should get index" do
    get student_papers_url, as: :json
    assert_response :success
  end

  test "should create student_paper" do
    assert_difference('StudentPaper.count') do
      post student_papers_url, params: { student_paper: { article_id: @student_paper.article_id, intern_id: @student_paper.intern_id } }, as: :json
    end

    assert_response 201
  end

  test "should show student_paper" do
    get student_paper_url(@student_paper), as: :json
    assert_response :success
  end

  test "should update student_paper" do
    patch student_paper_url(@student_paper), params: { student_paper: { article_id: @student_paper.article_id, intern_id: @student_paper.intern_id } }, as: :json
    assert_response 200
  end

  test "should destroy student_paper" do
    assert_difference('StudentPaper.count', -1) do
      delete student_paper_url(@student_paper), as: :json
    end

    assert_response 204
  end
end

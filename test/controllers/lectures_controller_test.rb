require 'test_helper'

class LecturesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @lecture = lectures(:one)
  end

  test "should get index" do
    get lectures_url, as: :json
    assert_response :success
  end

  test "should create lecture" do
    assert_difference('Lecture.count') do
      post lectures_url, params: { lecture: { institution_id: @lecture.institution_id, lecture_count: @lecture.lecture_count, name: @lecture.name, postgraduate_program_id: @lecture.postgraduate_program_id, workload: @lecture.workload, year: @lecture.year } }, as: :json
    end

    assert_response 201
  end

  test "should show lecture" do
    get lecture_url(@lecture), as: :json
    assert_response :success
  end

  test "should update lecture" do
    patch lecture_url(@lecture), params: { lecture: { institution_id: @lecture.institution_id, lecture_count: @lecture.lecture_count, name: @lecture.name, postgraduate_program_id: @lecture.postgraduate_program_id, workload: @lecture.workload, year: @lecture.year } }, as: :json
    assert_response 200
  end

  test "should destroy lecture" do
    assert_difference('Lecture.count', -1) do
      delete lecture_url(@lecture), as: :json
    end

    assert_response 204
  end
end

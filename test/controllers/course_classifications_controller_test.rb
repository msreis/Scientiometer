require 'test_helper'

class CourseClassificationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @course_classification = course_classifications(:one)
  end

  test "should get index" do
    get course_classifications_url, as: :json
    assert_response :success
  end

  test "should create course_classification" do
    assert_difference('CourseClassification.count') do
      post course_classifications_url, params: { course_classification: { classification: @course_classification.classification } }, as: :json
    end

    assert_response 201
  end

  test "should show course_classification" do
    get course_classification_url(@course_classification), as: :json
    assert_response :success
  end

  test "should update course_classification" do
    patch course_classification_url(@course_classification), params: { course_classification: { classification: @course_classification.classification } }, as: :json
    assert_response 200
  end

  test "should destroy course_classification" do
    assert_difference('CourseClassification.count', -1) do
      delete course_classification_url(@course_classification), as: :json
    end

    assert_response 204
  end
end

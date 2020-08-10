require 'test_helper'

class CourseDegreesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @course_degree = course_degrees(:one)
  end

  test "should get index" do
    get course_degrees_url, as: :json
    assert_response :success
  end

  test "should create course_degree" do
    assert_difference('CourseDegree.count') do
      post course_degrees_url, params: { course_degree: { degree: @course_degree.degree } }, as: :json
    end

    assert_response 201
  end

  test "should show course_degree" do
    get course_degree_url(@course_degree), as: :json
    assert_response :success
  end

  test "should update course_degree" do
    patch course_degree_url(@course_degree), params: { course_degree: { degree: @course_degree.degree } }, as: :json
    assert_response 200
  end

  test "should destroy course_degree" do
    assert_difference('CourseDegree.count', -1) do
      delete course_degree_url(@course_degree), as: :json
    end

    assert_response 204
  end
end

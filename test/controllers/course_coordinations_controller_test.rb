require 'test_helper'

class CourseCoordinationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @course_coordination = course_coordinations(:one)
  end

  test "should get index" do
    get course_coordinations_url, as: :json
    assert_response :success
  end

  test "should create course_coordination" do
    assert_difference('CourseCoordination.count') do
      post course_coordinations_url, params: { course_coordination: { course_classification_id: @course_coordination.course_classification_id, coordination_degree_id: @course_coordination.coordination_degree_id, name: @course_coordination.name, workload: @course_coordination.workload, year: @course_coordination.year } }, as: :json
    end

    assert_response 201
  end

  test "should show course_coordination" do
    get course_coordination_url(@course_coordination), as: :json
    assert_response :success
  end

  test "should update course_coordination" do
    patch course_coordination_url(@course_coordination), params: { course_coordination: { course_classification_id: @course_coordination.course_classification_id, coordination_degree_id: @course_coordination.coordination_degree_id, name: @course_coordination.name, workload: @course_coordination.workload, year: @course_coordination.year } }, as: :json
    assert_response 200
  end

  test "should destroy course_coordination" do
    assert_difference('CourseCoordination.count', -1) do
      delete course_coordination_url(@course_coordination), as: :json
    end

    assert_response 204
  end
end

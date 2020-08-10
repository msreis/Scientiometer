require 'test_helper'

class MinisteredClassesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ministered_class = ministered_classes(:one)
  end

  test "should get index" do
    get ministered_classes_url, as: :json
    assert_response :success
  end

  test "should create ministered_class" do
    assert_difference('MinisteredClass.count') do
      post ministered_classes_url, params: { ministered_class: { institution_id: @ministered_class.institution_id, postgraduate_program_id: @ministered_class.postgraduate_program_id, subject_id: @ministered_class.subject_id, year: @ministered_class.year } }, as: :json
    end

    assert_response 201
  end

  test "should show ministered_class" do
    get ministered_class_url(@ministered_class), as: :json
    assert_response :success
  end

  test "should update ministered_class" do
    patch ministered_class_url(@ministered_class), params: { ministered_class: { institution_id: @ministered_class.institution_id, postgraduate_program_id: @ministered_class.postgraduate_program_id, subject_id: @ministered_class.subject_id, year: @ministered_class.year } }, as: :json
    assert_response 200
  end

  test "should destroy ministered_class" do
    assert_difference('MinisteredClass.count', -1) do
      delete ministered_class_url(@ministered_class), as: :json
    end

    assert_response 204
  end
end

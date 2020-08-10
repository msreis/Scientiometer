require 'test_helper'

class ThesesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @thesis = theses(:one)
  end

  test "should get index" do
    get theses_url, as: :json
    assert_response :success
  end

  test "should create thesis" do
    assert_difference('Thesis.count') do
      post theses_url, params: { thesis: { advisement_id: @thesis.advisement_id, delivery_date: @thesis.delivery_date, finish_year: @thesis.finish_year, institution_id: @thesis.institution_id } }, as: :json
    end

    assert_response 201
  end

  test "should show thesis" do
    get thesis_url(@thesis), as: :json
    assert_response :success
  end

  test "should update thesis" do
    patch thesis_url(@thesis), params: { thesis: { advisement_id: @thesis.advisement_id, delivery_date: @thesis.delivery_date, finish_year: @thesis.finish_year, institution_id: @thesis.institution_id } }, as: :json
    assert_response 200
  end

  test "should destroy thesis" do
    assert_difference('Thesis.count', -1) do
      delete thesis_url(@thesis), as: :json
    end

    assert_response 204
  end
end

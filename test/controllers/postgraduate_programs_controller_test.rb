require 'test_helper'

class PostgraduateProgramsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @postgraduate_program = postgraduate_programs(:one)
  end

  test "should get index" do
    get postgraduate_programs_url, as: :json
    assert_response :success
  end

  test "should create postgraduate_program" do
    assert_difference('PostgraduateProgram.count') do
      post postgraduate_programs_url, params: { postgraduate_program: { name: @postgraduate_program.name } }, as: :json
    end

    assert_response 201
  end

  test "should show postgraduate_program" do
    get postgraduate_program_url(@postgraduate_program), as: :json
    assert_response :success
  end

  test "should update postgraduate_program" do
    patch postgraduate_program_url(@postgraduate_program), params: { postgraduate_program: { name: @postgraduate_program.name } }, as: :json
    assert_response 200
  end

  test "should destroy postgraduate_program" do
    assert_difference('PostgraduateProgram.count', -1) do
      delete postgraduate_program_url(@postgraduate_program), as: :json
    end

    assert_response 204
  end
end

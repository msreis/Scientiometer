require 'test_helper'

class AdvisementsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @advisement = advisements(:one)
  end

  test "should get index" do
    get advisements_url, as: :json
    assert_response :success
  end

  test "should create advisement" do
    assert_difference('Advisement.count') do
      post advisements_url, params: { advisement: { advisement_degree_id: @advisement.advisement_degree_id, intern_id: @advisement.intern_id, researcher_id: @advisement.researcher_id, supervisor_is_postdoc: @advisement.supervisor_is_postdoc, validity_end: @advisement.validity_end, validity_start: @advisement.validity_start } }, as: :json
    end

    assert_response 201
  end

  test "should show advisement" do
    get advisement_url(@advisement), as: :json
    assert_response :success
  end

  test "should update advisement" do
    patch advisement_url(@advisement), params: { advisement: { advisement_degree_id: @advisement.advisement_degree_id, intern_id: @advisement.intern_id, researcher_id: @advisement.researcher_id, supervisor_is_postdoc: @advisement.supervisor_is_postdoc, validity_end: @advisement.validity_end, validity_start: @advisement.validity_start } }, as: :json
    assert_response 200
  end

  test "should destroy advisement" do
    assert_difference('Advisement.count', -1) do
      delete advisement_url(@advisement), as: :json
    end

    assert_response 204
  end
end

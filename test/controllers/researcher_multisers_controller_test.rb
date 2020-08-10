require 'test_helper'

class ResearcherMultisersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @researcher_multiser = researcher_multisers(:one)
  end

  test "should get index" do
    get researcher_multisers_url, as: :json
    assert_response :success
  end

  test "should create researcher_multiser" do
    assert_difference('ResearcherMultiser.count') do
      post researcher_multisers_url, params: { researcher_multiser: { multiuser_id: @researcher_multiser.multiuser_id, researcher_id: @researcher_multiser.researcher_id, year: @researcher_multiser.year } }, as: :json
    end

    assert_response 201
  end

  test "should show researcher_multiser" do
    get researcher_multiser_url(@researcher_multiser), as: :json
    assert_response :success
  end

  test "should update researcher_multiser" do
    patch researcher_multiser_url(@researcher_multiser), params: { researcher_multiser: { multiuser_id: @researcher_multiser.multiuser_id, researcher_id: @researcher_multiser.researcher_id, year: @researcher_multiser.year } }, as: :json
    assert_response 200
  end

  test "should destroy researcher_multiser" do
    assert_difference('ResearcherMultiser.count', -1) do
      delete researcher_multiser_url(@researcher_multiser), as: :json
    end

    assert_response 204
  end
end

require 'test_helper'

class MultiuserSubjectsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @multiuser_subject = multiuser_subjects(:one)
  end

  test "should get index" do
    get multiuser_subjects_url, as: :json
    assert_response :success
  end

  test "should create multiuser_subject" do
    assert_difference('MultiuserSubject.count') do
      post multiuser_subjects_url, params: { multiuser_subject: { multiuser_id: @multiuser_subject.multiuser_id, subject_id: @multiuser_subject.subject_id, year: @multiuser_subject.year } }, as: :json
    end

    assert_response 201
  end

  test "should show multiuser_subject" do
    get multiuser_subject_url(@multiuser_subject), as: :json
    assert_response :success
  end

  test "should update multiuser_subject" do
    patch multiuser_subject_url(@multiuser_subject), params: { multiuser_subject: { multiuser_id: @multiuser_subject.multiuser_id, subject_id: @multiuser_subject.subject_id, year: @multiuser_subject.year } }, as: :json
    assert_response 200
  end

  test "should destroy multiuser_subject" do
    assert_difference('MultiuserSubject.count', -1) do
      delete multiuser_subject_url(@multiuser_subject), as: :json
    end

    assert_response 204
  end
end

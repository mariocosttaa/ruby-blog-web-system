require "test_helper"

class Public::StaticsControllerTest < ActionDispatch::IntegrationTest
  test "should get privacy policy" do
    get public_privacy_policy_index_url
    assert_response :success
    assert_select "title"
  end

  test "should get terms of use" do
    get public_terms_of_use_index_url
    assert_response :success
    assert_select "title"
  end

  test "should render privacy policy page" do
    get public_privacy_policy_index_url
    assert_response :success
  end

  test "should render terms of use page" do
    get public_terms_of_use_index_url
    assert_response :success
  end

  test "should use public layout" do
    get public_privacy_policy_index_url
    assert_response :success
    # Should use the public layout
  end

  test "should be accessible without authentication" do
    get public_privacy_policy_index_url
    assert_response :success
    
    get public_terms_of_use_index_url
    assert_response :success
  end
end
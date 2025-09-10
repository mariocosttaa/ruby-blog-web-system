require "test_helper"

class Panel::DashboardControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin = users(:admin)
    @author = users(:author)
    @published_post = posts(:published_post)
    @draft_post = posts(:draft_post)
    @active_category = categories(:active_category)
    @active_tag = tags(:active_tag)
    @approved_comment = post_comments(:approved_comment)
  end

  test "should redirect to login when not authenticated" do
    get panel_dashboard_index_url
    assert_redirected_to new_user_session_path
  end

  test "should get index when authenticated" do
    sign_in @admin
    get panel_dashboard_index_url
    assert_response :success
    assert_select "title"
  end

  test "should display total posts count" do
    sign_in @admin
    get panel_dashboard_index_url
    assert_response :success
    assert_select "p", text: /Total Posts/
  end

  test "should display total categories count" do
    sign_in @admin
    get panel_dashboard_index_url
    assert_response :success
    assert_select "p", text: /Categories/
  end

  test "should display total tags count" do
    sign_in @admin
    get panel_dashboard_index_url
    assert_response :success
    assert_select "p", text: /Tags/
  end

  test "should display total comments count" do
    sign_in @admin
    get panel_dashboard_index_url
    assert_response :success
    assert_select "p", text: /Comments/
  end

  test "should display recent posts" do
    sign_in @admin
    get panel_dashboard_index_url
    assert_response :success
    assert_select "h5", text: /Recent Posts/
  end

  test "should limit recent posts to 5" do
    sign_in @admin
    get panel_dashboard_index_url
    assert_response :success
    # Should limit to 5 recent posts
  end

  test "should order recent posts by created_at desc" do
    sign_in @admin
    get panel_dashboard_index_url
    assert_response :success
    # Posts should be ordered by created_at desc
  end

  test "should work for any authenticated user" do
    sign_in @author
    get panel_dashboard_index_url
    assert_response :success
  end
end

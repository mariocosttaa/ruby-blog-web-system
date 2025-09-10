require "test_helper"

class Panel::TagsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin = users(:admin)
    @author = users(:author)
    @active_tag = tags(:active_tag)
    @inactive_tag = tags(:inactive_tag)
  end

  test "should redirect to login when not authenticated" do
    get panel_tags_index_url
    assert_redirected_to new_user_session_path
  end

  test "should get index when authenticated" do
    sign_in @admin
    get panel_tags_index_url
    assert_response :success
    assert_select "title"
  end

  test "should get new when authenticated" do
    sign_in @admin
    get panel_new_tag_url
    assert_response :success
    assert_select "title"
  end

  test "should create tag with valid parameters" do
    sign_in @admin
    assert_difference('Tag.count') do
      post panel_create_tag_url, params: {
        tag: {
          name: "New Tag",
          status: true
        }
      }
    end
    assert_redirected_to panel_tags_index_path
    assert_equal "Tag was successfully created.", flash[:notice]
  end

  test "should not create tag with invalid parameters" do
    sign_in @admin
    assert_no_difference('Tag.count') do
      post panel_create_tag_url, params: {
        tag: {
          name: "",
          status: true
        }
      }
    end
    assert_response :unprocessable_entity
  end

  test "should get edit when authenticated" do
    sign_in @admin
    tag_hash = Hashids.new("tag-id", 12).encode(@active_tag.id)
    get panel_edit_tag_url(id: tag_hash)
    assert_response :success
    assert_select "title"
  end

  test "should update tag with valid parameters" do
    sign_in @admin
    tag_hash = Hashids.new("tag-id", 12).encode(@active_tag.id)
    patch panel_update_tag_url(id: tag_hash), params: {
      tag: {
        name: "Updated Tag",
        status: true
      }
    }
    assert_redirected_to panel_tags_index_path
    assert_equal "Tag was successfully updated.", flash[:notice]
  end

  test "should not update tag with invalid parameters" do
    sign_in @admin
    tag_hash = Hashids.new("tag-id", 12).encode(@active_tag.id)
    patch panel_update_tag_url(id: tag_hash), params: {
      tag: {
        name: "",
        status: true
      }
    }
    assert_response :unprocessable_entity
  end

  test "should destroy tag" do
    sign_in @admin
    tag_hash = Hashids.new("tag-id", 12).encode(@active_tag.id)
    assert_difference('Tag.count', -1) do
      delete panel_destroy_tag_url(id: tag_hash)
    end
    assert_redirected_to panel_tags_index_path
    assert_equal "Tag was successfully deleted.", flash[:notice]
  end

  test "should redirect when tag not found" do
    sign_in @admin
    get panel_edit_tag_url(id: "invalid-hash")
    assert_response :unprocessable_entity
  end

  test "should work for any authenticated user" do
    sign_in @author
    get panel_tags_index_url
    assert_response :success
  end

  test "should handle duplicate tag names" do
    sign_in @admin
    post panel_create_tag_url, params: {
      tag: {
        name: @active_tag.name,
        status: true
      }
    }
    assert_response :unprocessable_entity
  end
end

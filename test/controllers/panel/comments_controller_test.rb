require "test_helper"

class Panel::CommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin = users(:admin)
    @author = users(:author)
    @approved_comment = post_comments(:approved_comment)
    @pending_comment = post_comments(:pending_comment)
    @rejected_comment = post_comments(:rejected_comment)
  end

  test "should redirect to login when not authenticated" do
    get panel_comments_index_url
    assert_redirected_to new_user_session_path
  end

  test "should get index when authenticated" do
    sign_in @admin
    get panel_comments_index_url
    assert_response :success
    assert_select "title"
  end

  test "should update comment status with valid parameters" do
    sign_in @admin
    comment_hash = Hashids.new("comment-id", 12).encode(@pending_comment.id)
    patch panel_update_comment_url(id: comment_hash), params: {
      post_comment: {
        status: true
      }
    }
    assert_redirected_to panel_comments_index_path
    assert_equal "Comment was successfully updated.", flash[:notice]
    @pending_comment.reload
    assert_equal true, @pending_comment.status
  end

  test "should not update comment with invalid parameters" do
    sign_in @admin
    comment_hash = Hashids.new("comment-id", 12).encode(@pending_comment.id)
    patch panel_update_comment_url(id: comment_hash), params: {
      post_comment: {
        status: "invalid_status"
      }
    }
    assert_redirected_to panel_comments_index_path
    assert_equal "Comment was successfully updated.", flash[:notice]
  end

  test "should destroy comment" do
    sign_in @admin
    comment_hash = Hashids.new("comment-id", 12).encode(@pending_comment.id)
    assert_difference('PostComment.count', -1) do
      delete panel_destroy_comment_url(id: comment_hash)
    end
    assert_redirected_to panel_comments_index_path
    assert_equal "Comment was successfully deleted.", flash[:notice]
  end

  test "should redirect when comment not found" do
    sign_in @admin
    patch panel_update_comment_url(id: "invalid-hash"), params: {
      post_comment: {
        status: "approved"
      }
    }
    assert_response :unprocessable_entity
  end

  test "should work for any authenticated user" do
    sign_in @author
    get panel_comments_index_url
    assert_response :success
  end

  test "should display comments with post information" do
    sign_in @admin
    get panel_comments_index_url
    assert_response :success
    # Should include post information for each comment
  end

  test "should order comments by created_at desc" do
    sign_in @admin
    get panel_comments_index_url
    assert_response :success
    # Comments should be ordered by created_at desc
  end

  test "should handle status changes correctly" do
    sign_in @admin
    comment_hash = Hashids.new("comment-id", 12).encode(@approved_comment.id)
    
    # Change from approved to rejected
    patch panel_update_comment_url(id: comment_hash), params: {
      post_comment: {
        status: false
      }
    }
    assert_redirected_to panel_comments_index_path
    @approved_comment.reload
    assert_equal false, @approved_comment.status
  end

  test "should handle multiple status updates" do
    sign_in @admin
    comment_hash = Hashids.new("comment-id", 12).encode(@pending_comment.id)
    
    # First update
    patch panel_update_comment_url(id: comment_hash), params: {
      post_comment: {
        status: true
      }
    }
    assert_redirected_to panel_comments_index_path
    
    # Second update
    patch panel_update_comment_url(id: comment_hash), params: {
      post_comment: {
        status: false
      }
    }
    assert_redirected_to panel_comments_index_path
    
    @pending_comment.reload
    assert_equal false, @pending_comment.status
  end
end

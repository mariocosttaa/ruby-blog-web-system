require "test_helper"

class Panel::PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin = users(:admin)
    @author = users(:author)
    @published_post = posts(:published_post)
    @draft_post = posts(:draft_post)
    @active_category = categories(:active_category)
    @active_tag = tags(:active_tag)
  end

  test "should redirect to login when not authenticated" do
    get panel_posts_index_url
    assert_redirected_to new_user_session_path
  end

  test "should get index when authenticated" do
    sign_in @admin
    get panel_posts_index_url
    assert_response :success
    assert_select "title"
  end

  test "should get new when authenticated" do
    sign_in @admin
    get panel_new_post_url
    assert_response :success
    assert_select "title"
  end

  test "should create post with valid parameters" do
    sign_in @admin
    assert_difference('Post.count') do
      post panel_create_post_url, params: {
        post: {
          title: "New Test Post",
          description: "This is a new test post with a description that is long enough to meet the minimum requirement of 100 characters for validation purposes.",
          status: true,
          categories: [@active_category.name],
          tags: "ruby, rails, test"
        }
      }
    end
    assert_redirected_to panel_posts_index_path
    assert_equal "Post was successfully created.", flash[:notice]
  end

  test "should not create post without categories" do
    sign_in @admin
    assert_no_difference('Post.count') do
      post panel_create_post_url, params: {
        post: {
          title: "New Test Post",
          description: "This is a new test post with a description that is long enough to meet the minimum requirement of 100 characters for validation purposes.",
          status: true,
          categories: [],
          tags: "ruby, rails, test"
        }
      }
    end
    assert_redirected_to panel_create_post_path
    assert_equal "Categories are required.", flash[:notice]
  end

  test "should not create post without tags" do
    sign_in @admin
    assert_no_difference('Post.count') do
      post panel_create_post_url, params: {
        post: {
          title: "New Test Post",
          description: "This is a new test post with a description that is long enough to meet the minimum requirement of 100 characters for validation purposes.",
          status: true,
          categories: [@active_category.name],
          tags: ""
        }
      }
    end
    assert_redirected_to panel_create_post_path
    assert_equal "Tags are required.", flash[:notice]
  end

  test "should not create post with invalid parameters" do
    sign_in @admin
    assert_no_difference('Post.count') do
      post panel_create_post_url, params: {
        post: {
          title: "",
          description: "Short",
          status: true,
          categories: [@active_category.name],
          tags: "ruby, rails, test"
        }
      }
    end
    assert_response :unprocessable_entity
  end

  test "should get edit when authenticated" do
    sign_in @admin
    # We need to get the hash ID for the post
    post_hash = Hashids.new("post-id", 12).encode(@published_post.id)
    get panel_edit_post_url(id: post_hash)
    assert_response :success
    assert_select "title"
  end

  test "should update post with valid parameters" do
    sign_in @admin
    post_hash = Hashids.new("post-id", 12).encode(@published_post.id)
    patch panel_update_post_url(id: post_hash), params: {
      post: {
        title: "Updated Post Title",
        description: "This is an updated post with a description that is long enough to meet the minimum requirement of 100 characters for validation purposes.",
        status: true,
        categories: [@active_category.name],
        tags: "updated, tags"
      }
    }
    assert_redirected_to panel_posts_index_path
    assert_equal "Post was successfully updated.", flash[:notice]
  end

  test "should not update post without categories" do
    sign_in @admin
    post_hash = Hashids.new("post-id", 12).encode(@published_post.id)
    patch panel_update_post_url(id: post_hash), params: {
      post: {
        title: "Updated Post Title",
        description: "This is an updated post with a description that is long enough to meet the minimum requirement of 100 characters for validation purposes.",
        status: true,
        categories: [],
        tags: "updated, tags"
      }
    }
    assert_redirected_to panel_edit_post_path(@published_post)
    assert_equal "Categories are required.", flash[:notice]
  end

  test "should not update post without tags" do
    sign_in @admin
    post_hash = Hashids.new("post-id", 12).encode(@published_post.id)
    patch panel_update_post_url(id: post_hash), params: {
      post: {
        title: "Updated Post Title",
        description: "This is an updated post with a description that is long enough to meet the minimum requirement of 100 characters for validation purposes.",
        status: true,
        categories: [@active_category.name],
        tags: ""
      }
    }
    assert_redirected_to panel_edit_post_path(@published_post)
    assert_equal "Tags are required.", flash[:notice]
  end

  test "should not update post with invalid parameters" do
    sign_in @admin
    post_hash = Hashids.new("post-id", 12).encode(@published_post.id)
    patch panel_update_post_url(id: post_hash), params: {
      post: {
        title: "",
        description: "Short",
        status: true,
        categories: [@active_category.name],
        tags: "updated, tags"
      }
    }
    assert_response :unprocessable_entity
  end

  test "should destroy post" do
    sign_in @admin
    post_hash = Hashids.new("post-id", 12).encode(@published_post.id)
    assert_difference('Post.count', -1) do
      delete panel_destroy_post_url(id: post_hash)
    end
    assert_redirected_to panel_posts_index_path
    assert_equal "Post was successfully deleted.", flash[:notice]
  end

  test "should redirect when post not found" do
    sign_in @admin
    get panel_edit_post_url(id: "invalid-hash")
    assert_response :unprocessable_entity
  end

  test "should create new categories and tags when they don't exist" do
    sign_in @admin
    assert_difference('Category.count') do
      assert_difference('Tag.count', 2) do
        post panel_create_post_url, params: {
          post: {
            title: "New Test Post",
            description: "This is a new test post with a description that is long enough to meet the minimum requirement of 100 characters for validation purposes.",
            status: true,
            categories: ["New Category"],
            tags: "new-tag, another-tag"
          }
        }
      end
    end
    assert_redirected_to panel_posts_index_path
  end

  test "should handle image upload" do
    sign_in @admin
    post panel_create_post_url, params: {
      post: {
        title: "New Test Post",
        description: "This is a new test post with a description that is long enough to meet the minimum requirement of 100 characters for validation purposes.",
        status: true,
        categories: [@active_category.name],
        tags: "ruby, rails, test",
        image: fixture_file_upload("test/fixtures/files/test_image.jpg", "image/jpeg")
      }
    }
    assert_redirected_to panel_posts_index_path
    # Note: This test would need a test image file to work properly
  end
end
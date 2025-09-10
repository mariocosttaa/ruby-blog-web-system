require "test_helper"

class Public::ArticlesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @published_post = posts(:published_post)
    @draft_post = posts(:draft_post)
    @another_published_post = posts(:another_published_post)
  end

  test "should get index and show only published posts" do
    get public_articles_index_url
    assert_response :success
    assert_select "title"
  end

  test "should get show for published post" do
    get public_article_show_url(slug: @published_post.slug)
    assert_response :success
    assert_select "title"
  end

  test "should return 404 when post not found" do
    get public_article_show_url(slug: "non-existent-post")
    assert_response :not_found
  end

  test "should return 404 when trying to access draft post" do
    get public_article_show_url(slug: @draft_post.slug)
    assert_response :not_found
  end

  test "should create comment with valid parameters" do
    assert_difference('PostComment.count') do
      patch public_article_comment_url(slug: @published_post.slug), params: {
        post_comment: {
          name: "Test User",
          email: "test@example.com",
          comment: "This is a test comment"
        }
      }
    end
    assert_redirected_to public_article_show_path(@published_post.slug)
    assert_equal "Comment was successfully created.", flash[:notice]
  end

  test "should not create comment with invalid parameters" do
    assert_no_difference('PostComment.count') do
      patch public_article_comment_url(slug: @published_post.slug), params: {
        post_comment: {
          name: "",
          email: "invalid-email",
          comment: ""
        }
      }
    end
    assert_response :unprocessable_content
  end

  test "should not create comment for non-existent post" do
    assert_no_difference('PostComment.count') do
      patch public_article_comment_url(slug: "non-existent-post"), params: {
        post_comment: {
          name: "Test User",
          email: "test@example.com",
          comment: "This is a test comment"
        }
      }
    end
    assert_response :not_found
  end

  test "should not create comment for draft post" do
    assert_no_difference('PostComment.count') do
      patch public_article_comment_url(slug: @draft_post.slug), params: {
        post_comment: {
          name: "Test User",
          email: "test@example.com",
          comment: "This is a test comment"
        }
      }
    end
    assert_response :not_found
  end
end

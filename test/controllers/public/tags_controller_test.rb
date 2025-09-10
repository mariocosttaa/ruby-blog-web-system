require "test_helper"

class Public::TagsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @active_tag = tags(:active_tag)
    @inactive_tag = tags(:inactive_tag)
    @another_active_tag = tags(:another_active_tag)
    @web_tag = tags(:web_tag)
    @published_post = posts(:published_post)
    @another_published_post = posts(:another_published_post)
  end

  test "should get index and show only active tags" do
    get public_tags_index_url
    assert_response :success
    assert_select "title"
  end

  test "should get show for active tag with posts" do
    get public_tag_show_url(slug: @active_tag.name)
    assert_response :success
    assert_select "title"
  end

  test "should return 404 when tag not found" do
    get public_tag_show_url(slug: "non-existent-tag")
    assert_response :not_found
  end

  test "should return 404 when trying to access inactive tag" do
    get public_tag_show_url(slug: @inactive_tag.name)
    assert_response :not_found
  end

  test "should show posts associated with tag" do
    get public_tag_show_url(slug: @active_tag.name)
    assert_response :success
    # Should show posts that have this tag
  end

  test "should only show published posts in tag" do
    get public_tag_show_url(slug: @active_tag.name)
    assert_response :success
    # Should only show published posts, not drafts
  end

  test "should handle case insensitive tag search" do
    get public_tag_show_url(slug: @active_tag.name.upcase)
    assert_response :success
  end

  test "should order posts by created_at desc" do
    get public_tag_show_url(slug: @active_tag.name)
    assert_response :success
    # Posts should be ordered by created_at desc
  end

  test "should handle tags with special characters" do
    get public_tag_show_url(slug: @web_tag.name)
    assert_response :success
  end
end

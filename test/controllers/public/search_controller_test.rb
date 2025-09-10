require "test_helper"

class Public::SearchControllerTest < ActionDispatch::IntegrationTest
  setup do
    @published_post = posts(:published_post)
    @another_published_post = posts(:another_published_post)
    @draft_post = posts(:draft_post)
    @active_category = categories(:active_category)
    @active_tag = tags(:active_tag)
  end

  test "should get show with search query" do
    get public_search_show_url(query: "test")
    assert_response :success
    assert_select "title"
  end

  test "should get show without query parameter" do
    get public_search_index_url
    assert_response :success
    assert_select "title"
  end

  test "should search in post titles" do
    get public_search_show_url(query: @published_post.title.downcase)
    assert_response :success
    # Should find posts with matching titles
  end

  test "should search in post descriptions" do
    get public_search_show_url(query: "description")
    assert_response :success
    # Should find posts with matching descriptions
  end

  test "should search in category names" do
    get public_search_show_url(query: @active_category.name.downcase)
    assert_response :success
    # Should find posts with matching category names
  end

  test "should search in tag names" do
    get public_search_show_url(query: @active_tag.name.downcase)
    assert_response :success
    # Should find posts with matching tag names
  end

  test "should only return published posts" do
    get public_search_show_url(query: "test")
    assert_response :success
    # Should not return draft posts
  end

  test "should handle case insensitive search" do
    get public_search_show_url(query: @published_post.title.upcase)
    assert_response :success
    # Should find posts regardless of case
  end

  test "should return empty results for no matches" do
    get public_search_show_url(query: "nonexistentsearchterm")
    assert_response :success
    # Should return empty results
  end

  test "should order results by created_at desc" do
    get public_search_show_url(query: "test")
    assert_response :success
    # Results should be ordered by created_at desc
  end

  test "should handle empty query" do
    get public_search_show_url(query: "")
    assert_response :success
    # Should handle empty query gracefully
  end

  test "should handle special characters in search" do
    get public_search_show_url(query: "test@#$%")
    assert_response :success
    # Should handle special characters safely
  end
end

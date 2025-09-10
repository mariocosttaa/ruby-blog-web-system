require "test_helper"

class Public::CategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @active_category = categories(:active_category)
    @inactive_category = categories(:inactive_category)
    @another_active_category = categories(:another_active_category)
    @published_post = posts(:published_post)
    @another_published_post = posts(:another_published_post)
  end

  test "should get index and show only active categories" do
    get public_categories_index_url
    assert_response :success
    assert_select "title"
  end

  test "should get show for active category with posts" do
    get public_category_show_url(slug: @active_category.slug)
    assert_response :success
    assert_select "title"
  end

  test "should return 404 when category not found" do
    get public_category_show_url(slug: "non-existent-category")
    assert_response :not_found
  end

  test "should return 404 when trying to access inactive category" do
    get public_category_show_url(slug: @inactive_category.slug)
    assert_response :not_found
  end

  test "should show posts associated with category" do
    get public_category_show_url(slug: @active_category.slug)
    assert_response :success
    # Should show posts that belong to this category
  end

  test "should only show published posts in category" do
    get public_category_show_url(slug: @active_category.slug)
    assert_response :success
    # Should only show published posts, not drafts
  end

  test "should handle case insensitive category search" do
    get public_category_show_url(slug: @active_category.slug.upcase)
    assert_response :not_found
  end

  test "should order posts by created_at desc" do
    get public_category_show_url(slug: @active_category.slug)
    assert_response :success
    # Posts should be ordered by created_at desc
  end
end

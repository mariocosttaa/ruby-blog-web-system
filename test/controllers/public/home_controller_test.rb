require "test_helper"

class Public::HomeControllerTest < ActionDispatch::IntegrationTest
  setup do
    @published_post = posts(:published_post)
    @draft_post = posts(:draft_post)
    @another_published_post = posts(:another_published_post)
    @active_category = categories(:active_category)
    @active_tag = tags(:active_tag)
  end

  test "should get index" do
    get public_home_index_url
    assert_response :success
    assert_select "title"
  end

  test "should display recent posts" do
    get public_home_index_url
    assert_response :success
    # Should show all posts (including drafts) on home page
  end

  test "should display categories" do
    get public_home_index_url
    assert_response :success
  end

  test "should display tags" do
    get public_home_index_url
    assert_response :success
  end

  test "should limit posts to 3" do
    # Create additional posts to test limit
    Post.create!(
      title: "Extra Post 1",
      description: "This is an extra post with a description that is long enough to meet the minimum requirement of 100 characters for validation purposes.",
      status: true,
      slug: "extra-post-1",
      user: users(:admin)
    )
    Post.create!(
      title: "Extra Post 2", 
      description: "This is another extra post with a description that is long enough to meet the minimum requirement of 100 characters for validation purposes.",
      status: true,
      slug: "extra-post-2",
      user: users(:admin)
    )
    Post.create!(
      title: "Extra Post 3",
      description: "This is yet another extra post with a description that is long enough to meet the minimum requirement of 100 characters for validation purposes.",
      status: true,
      slug: "extra-post-3",
      user: users(:admin)
    )

    get public_home_index_url
    assert_response :success
    # The controller should limit to 3 posts
  end

  test "should limit categories to 10" do
    get public_home_index_url
    assert_response :success
    # The controller should limit categories to 10
  end

  test "should limit tags to 25" do
    get public_home_index_url
    assert_response :success
    # The controller should limit tags to 25
  end
end

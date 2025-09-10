require "test_helper"

class Panel::CategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin = users(:admin)
    @author = users(:author)
    @active_category = categories(:active_category)
    @inactive_category = categories(:inactive_category)
  end

  test "should redirect to login when not authenticated" do
    get panel_categories_index_url
    assert_redirected_to new_user_session_path
  end

  test "should get index when authenticated" do
    sign_in @admin
    get panel_categories_index_url
    assert_response :success
    assert_select "title"
  end

  test "should get new when authenticated" do
    sign_in @admin
    get panel_new_category_url
    assert_response :success
    assert_select "title"
  end

  test "should create category with valid parameters" do
    sign_in @admin
    assert_difference('Category.count') do
      post panel_create_category_url, params: {
        category: {
          name: "New Category",
          description: "This is a new test category",
          status: true
        }
      }
    end
    assert_redirected_to panel_categories_index_path
    assert_equal "Category was successfully created.", flash[:notice]
  end

  test "should not create category with invalid parameters" do
    sign_in @admin
    assert_no_difference('Category.count') do
      post panel_create_category_url, params: {
        category: {
          name: "",
          description: "This is a new test category",
          status: true
        }
      }
    end
    assert_response :unprocessable_entity
  end

  test "should get edit when authenticated" do
    sign_in @admin
    category_hash = Hashids.new("category-id", 12).encode(@active_category.id)
    get panel_edit_category_url(id: category_hash)
    assert_response :success
    assert_select "title"
  end

  test "should update category with valid parameters" do
    sign_in @admin
    category_hash = Hashids.new("category-id", 12).encode(@active_category.id)
    patch panel_update_category_url(id: category_hash), params: {
      category: {
        name: "Updated Category",
        description: "This is an updated test category",
        status: true
      }
    }
    assert_redirected_to panel_categories_index_path
    assert_equal "Category was successfully updated.", flash[:notice]
  end

  test "should not update category with invalid parameters" do
    sign_in @admin
    category_hash = Hashids.new("category-id", 12).encode(@active_category.id)
    patch panel_update_category_url(id: category_hash), params: {
      category: {
        name: "",
        description: "This is an updated test category",
        status: true
      }
    }
    assert_response :unprocessable_entity
  end

  test "should destroy category" do
    sign_in @admin
    category_hash = Hashids.new("category-id", 12).encode(@active_category.id)
    assert_difference('Category.count', -1) do
      delete panel_destroy_category_url(id: category_hash)
    end
    assert_redirected_to panel_categories_index_path
    assert_equal "Category was successfully deleted.", flash[:notice]
  end

  test "should redirect when category not found" do
    sign_in @admin
    get panel_edit_category_url(id: "invalid-hash")
    assert_response :unprocessable_entity
  end

  test "should generate slug from name" do
    sign_in @admin
    post panel_create_category_url, params: {
      category: {
        name: "Test Category Name",
        description: "This is a test category",
        status: true
      }
    }
    assert_redirected_to panel_categories_index_path
    category = Category.last
    assert_equal "test-category-name", category.slug
  end

  test "should work for any authenticated user" do
    sign_in @author
    get panel_categories_index_url
    assert_response :success
  end
end

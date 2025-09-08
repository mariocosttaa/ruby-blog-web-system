require "test_helper"

class Panel::CategoriesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get panel_categories_index_url
    assert_response :success
  end

  test "should get show," do
    get panel_categories_show, _url
    assert_response :success
  end

  test "should get new," do
    get panel_categories_new, _url
    assert_response :success
  end

  test "should get edit," do
    get panel_categories_edit, _url
    assert_response :success
  end

  test "should get create," do
    get panel_categories_create, _url
    assert_response :success
  end

  test "should get update," do
    get panel_categories_update, _url
    assert_response :success
  end

  test "should get destroy" do
    get panel_categories_destroy_url
    assert_response :success
  end
end

require "test_helper"

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @category = Category.create(name: "yoooz")
    @user = User.create(username: "jjj", email: "aaa@aa.com", password: "a", admin: true)
  end

  test "should get index" do
    get categories_path
    assert_response :success
  end

  test "should get new" do
    sign_in_as(@user, "a")
    get new_category_path
    assert_response :success
  end

  test "should get show" do
    get category_path(@category)
    assert_response :success
  end

  test "should redirect when not admin" do
    assert_no_difference "Category.count" do
      post categories_path, params: { category: { name: "Bahaha" } }
    end

    assert_redirected_to categories_path
  end
end

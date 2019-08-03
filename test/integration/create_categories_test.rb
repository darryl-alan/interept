require "test_helper"

class CreateCategoriesTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create(username: "jjj", email: "aaa@aa.com", password: "a", admin: true)
  end

  test "get new category form and create category" do
    sign_in_as(@user, "a")
    get new_category_path
    assert_template "categories/new"

    assert_difference "Category.count", 1 do
      post categories_path, params: { category: { name: "zzzzz" } }
      follow_redirect!
    end

    assert_template "categories/index"
    assert_match "zzzzz", response.body
  end

  test "invalid category should be rejected" do
    sign_in_as(@user, "a")
    get new_category_path
    assert_template "categories/new"

    assert_no_difference "Category.count" do
      post categories_path, params: { category: { name: " " } }
      #follow_redirect!
    end

    assert_template "categories/new" #because if error then new is rendered
    assert_select "h2.panel-title.errors-title"
    assert_select "div.panel-body.errors-body"
  end
end

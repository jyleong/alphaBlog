require "test_helper"

class CreateCategoriesTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = User.create(username: "john", email: "john@email.com", password: "password", admin: true)
    ## but need to log in this user at controller level
  end
  
  test "get new category form and create category" do
    sign_in_as(@user, "password")
    get new_category_path
    assert_template 'categories/new'
    assert_difference 'Category.count', 1 do
      post_via_redirect categories_path, category: {name: "sports"}
    end
    assert_template 'categories/index'
    assert_match "sports", response.body
  end
  
  test "invalid category submission results in failure" do
    sign_in_as(@user, "password")
    get new_category_path
    assert_template 'categories/new'
    assert_difference 'Category.count', 0 do
      ## no change in my category count
      post categories_path, category: {name: ""}
    end
    assert_template 'categories/new'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
    ## look for tiel and body from errors partials
    
  end
  
  test "should make proper article with categories" do
    sign_in_as(@user, "password")
    get new_article_path
    assert_template 'articles/new'
    assert_difference 'Article.count', 1 do
      post articles_path, article: {title: "this article", description: "description of this article test", user_id: @user.id}
    end
    assert_template article_path(@article)
    
  end
end
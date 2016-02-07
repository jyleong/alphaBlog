require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase ## different subclass for controller tests
  
  def setup
    @category = Category.create(name: "sports")
    @user = User.create(username: "john", email: "john@email.com", password: "password", admin: true)
    ## but need to log in this user at controller level
    
  end
  
  test "should get categories index" do
    
    get :index ##ensure able to get index
    assert_response :success
  end
  
  test "should get new" do
    session[:user_id] = @user.id ## set session at controller level, simulate logged in user as Admin
    get :new
    assert_response :success
  end
  
  test "should get show" do
    get(:show, {'id' => @category.id})
    assert_response :success
  end
  
  test "should redirect create when admin not logged in" do
    assert_no_difference 'Category.count' do
      post :create, category: {name: "sports"}
    end
    assert_redirected_to categories_path
  end
  
end
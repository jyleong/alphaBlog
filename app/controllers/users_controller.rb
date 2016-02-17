class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update,:show]
  before_action :require_same_user, only: [:edit, :update]
  before_action :require_admin, only: [:destroy]
  def index
    @users = User.paginate(page: params[:page], per_page:5)
  end

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      ## set session
      session[:user_id] = @user.id
      flash[:success] = "Welcome to the alphaBlog #{@user.username}"
      ## gives user output for confrmation
      
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end
  
  
  def edit
    
  end
  
  def my_friends
    @friendships = current_user.friends
  end

  def update ## refer here for update and create
    
    if @user.update(user_params)
      flash[:success] = "Your account is updated #{@user.username}"
      ## gives user output for confrmation
      redirect_to articles_path
    else
      render 'new'
    end
  end

  def show
    
    @user_articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:danger] = "User and all articles creatd by user have been deleted"
    redirect_to users_path
  end
  
  def add_friend
    @friend = User.find(params[:friend])
    current_user.friendships.build(friend_id: @friend.id)
    
    if current_user.save
      redirect_to my_friends_path, notice: "Friend was successfully added"
    else
      redirect_to my_friends_path, flash[:error] = "There was an error with adding user as friend"
    end
  end
  
  private
  
  def set_user
    @user = User.find(params[:id])
  end
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
  
  def require_same_user
    if current_user != @user and !current_user.admin?
      flash[:danger] = "You can only edit your own account"
      redirect_to root_path
    end
  end
  
  
  def require_admin
    if logged_in? and !current_user.admin?
      flash[:danger] = "Only admin users can perform that action"
      redirect_to root_path
    end
    
  end

end
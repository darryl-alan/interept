class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show, :destroy]
  before_action :require_user, only: [:edit, :update, :destroy]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  before_action :require_admin, only: :destroy

  def new
    @user = User.new
  end

  def add
    @user = User.new
  end

  def index
    @users = User.paginate(page: params[:page], per_page: 2)
  end

  def create
    @user = User.new(user_params)

    if @user.save
      if logged_in?
        flash[:success] = "User added"
      else
        session[:user_id] = @user.id
        flash[:success] = "You've signed up, welcome!"
      end
      redirect_to user_path(@user)
    else
      render :new
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = "User deleted"
    else
      flash[:danger] = "Something went wrong"
    end

    redirect_to users_path
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = "User updated"
      redirect_to reports_path
    else
      render :edit
    end
  end

  def show
    @user_reports = @user.reports.paginate(page: params[:page], per_page: 1)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    if logged_in? && current_user.admin?
      params.require(:user).permit(:username, :email, :password, :admin)
    else
      params.require(:user).permit(:username, :email, :password)
    end
  end

  def require_same_user
    if !logged_in? || (current_user != @user && !current_user.admin?)
      flash[:danger] = "You are not authorized"
      redirect_to users_path
    end
  end

  def require_admin
    if !logged_in? || !current_user.admin?
      flash[:danger] = "You are not authorized"
      redirect_to users_path
    end
  end
end

class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(username: params[:session][:username].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:success] = "Logged in successfully"
      redirect_to user_path(user)
    else
      flash.now[:danger] = "Invalid login credentials"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "You're logged out"
    redirect_to root_path
  end
end

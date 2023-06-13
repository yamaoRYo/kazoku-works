class UserSessionsController < ApplicationController
  skip_before_action :require_login, except: %i[destroy]

  def new
    @user = User.new
  end

  def create
    @user = login(params[:email], params[:password])
  
    if @user
      redirect_back_or_to families_path, notice: 'Logged in!'
    else
      flash[:alert] = 'Login failed.'
      redirect_to login_path
    end
  end
  
  def destroy
    logout
    redirect_to root_path, :notice => "Logged out!"
  end
end
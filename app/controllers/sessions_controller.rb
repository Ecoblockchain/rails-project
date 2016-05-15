class SessionsController < ApplicationController
  skip_filter :store_location

  def new
  end

  def create
    user = User.find_by name: params[:name]
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to prev_location
    else
      redirect_to :back, notice: "Username or password incorrect."
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to :root
  end
end

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def signed_in?
    !current_user.nil?
  end

  def ensure_signed_in
    redirect_to login_path,
                notice: "You need to be logged
                         in to complete this action." if !signed_in?
  end
end

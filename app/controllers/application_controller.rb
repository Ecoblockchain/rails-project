class ApplicationController < ActionController::Base
  before_filter :store_location
  protect_from_forgery with: :exception

  helper_method :signed_in?

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

  def store_location
    return unless request.get? and !request.xhr? and
      (request.format == "text/html" or request.content_type == "text/html")
    session[:prev_location] = request.fullpath
  end

  def prev_location
    session[:prev_location] || :root
  end

  def ensure_json_request
    return if params[:format] == "json" || request.headers["Accept"] =~ /json/
    render :nothing => true, :status => 406
  end
end

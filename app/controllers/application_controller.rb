class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  layout proc{|c| c.request.xhr? ? false : "application" }

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
  helper_method :current_user

  def set_current_user
    Observer.current_user = current_user
  end
  before_filter :set_current_user
end

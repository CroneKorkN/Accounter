class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  layout proc{ |c| c.request.xhr? ? false : "application" }

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
  helper_method :current_user

  def set_current_user
    Observer.current_user = current_user
  end
  before_action :set_current_user
end

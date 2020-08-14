class ApplicationController < ActionController::Base
  include SessionHelper
  before_action :require_login, :is_login, :set_current_user

  def require_login
    redirect_to login_path unless log_in?
  end

  def set_current_user
    Base.current = current_user
  end
  def is_login
    current_user.present?
    # puts "@current_user : #{@current_user}"
    # logged_in
  end

end

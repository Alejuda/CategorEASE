class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authenticate_user!, :update_allowed_parameters, if: :devise_controller?

  protected

  def update_allowed_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password) }
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :email, :password, :current_password) }
  end

  def authenticate_user!
    if user_signed_in?
      super
    else
      unless request.path == new_user_session_path || request.path == new_user_registration_path || request.path == new_user_password_path
        redirect_to not_logged_in_path
      end
    end
  end
end

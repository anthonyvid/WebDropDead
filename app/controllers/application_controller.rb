class ApplicationController < ActionController::Base
  helper_method :current_user, :user_signed_in?

  # Redirect to sign in if not authenticated
  def authenticate_user!
    unless user_signed_in?
      redirect_to sign_in_path, alert: 'Please sign in first.'
    end
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  # Checks if a user is logged in
  def user_signed_in?
    current_user.present?
  end
end
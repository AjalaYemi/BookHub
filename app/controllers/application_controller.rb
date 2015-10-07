class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

protected

# Whitelisting of parameters added to user outside Devise
def configure_permitted_parameters
  devise_parameter_sanitizer.for(:sign_up) << :first_name#, :last_name, :username
  devise_parameter_sanitizer.for(:account_update) << :first_name#, :last_name, :username
end

  private

  def confirm_logged_in
  	unless session[:user_id]
  		flash[:notice] = "Please log in"
  		redirect_to(:controller => 'access', :action => 'login')
  		return false
  	else
  		return true
  	end
  end
end

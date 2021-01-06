class ApplicationController < ActionController::Base
	protect_from_forgery
	before_action :authenticate_user!
	before_action :configure_permitted_parameters, if: :devise_controller?
	def configure_permitted_parameters
		devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :usertype])
		devise_parameter_sanitizer.permit(:account_update, keys: [:name, :usertype])
	end
	rescue_from CanCan::AccessDenied do |exception|
	    respond_to do |format|
	      format.html { redirect_to root_path, alert: exception.message }
	    end
	 end
end

class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?



  # protected
  # def after_sign_in_path_for(resource)
  #   if resource.admin?
  #     root_path
  #   else
  #     root_path
  #   end
  # end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  def after_sign_in_path_for(resource)
    @current_user = resource
    AdminMailer.check_in_email(resource).deliver_now
    root_path
  end
end

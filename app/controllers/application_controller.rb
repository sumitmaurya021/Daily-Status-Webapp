class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?


  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  def after_sign_in_path_for(resource)
    @current_user = resource
    if resource.role == "admin"
      root_path
    else
      Log.create(user_id: resource.id, timestamp: Time.now, action: 'check-in')
      AdminMailer.check_in_email(resource).deliver_now
      root_path
    end
  end
end

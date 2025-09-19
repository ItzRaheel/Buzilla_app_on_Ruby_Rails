class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  include Pundit::Authorization
  before_action :authenticate_user!
  # debugger

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
# rescue_from CanCan::AccessDenied do |exception|
#   redirect_to bugs_path,:alert => exception.message
# end

    include CanCan::ControllerAdditions
  #  load_and_authorize_resource

  before_action :configure_permitted_parameters, if: :devise_controller?
  # before_action :configure_permitted_to_signin, if: :devise_controller?

  private 
  def user_not_authorized(exception)
    policy_name = exception.policy.class.to_s.underscore
    redirect_to root_path,notice: "You are not authorized "
  end
  protected

#   def configure_permitted_to_signin 
#     devise_parameter_sanitizer.permit(:sign_in) do |params|
#       params.permit(:name,:email)
#   end
# end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end
end

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :current_cart

  before_action :configure_permitted_parameters, if: :devise_controller?

  def verify_is_admin
    redirect_to(root_path) unless current_user&.admin
  end

  def verify_is_support
    redirect_to(root_path) unless current_user&.support
  end

  def current_cart
    @current_cart ||= Carts::Operation::CurrentCart.new(session).call
  end
  
  private
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name])
  end

end

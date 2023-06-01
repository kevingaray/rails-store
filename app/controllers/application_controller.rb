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
    @current_cart ||= find_or_create_cart
  end
  
  private
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name])
  end

  def find_or_create_cart
    if session[:cart_id]
      cart = Cart.find_by(id: session[:cart_id])
      if cart.present?
        return cart
      else
        session[:cart_id] = nil
      end
    end
  
    create_new_cart
  end
  
  def create_new_cart
    cart = Cart.create
    session[:cart_id] = cart.id
    cart
  end

end

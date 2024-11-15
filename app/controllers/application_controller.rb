class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  helper_method :current_cart

  def current_cart
    if user_signed_in?
      @current_cart ||= Cart.find_or_create_by(user: current_user)
    else
      redirect_to new_user_session_path, alert: "Please log in to access your cart."
    end
  end
end

class ApplicationController < ActionController::Base
  allow_browser versions: :modern
  helper_method :current_cart


  def current_cart
    return nil unless user_signed_in?
    @current_cart ||= Cart.find_or_create_by(user: current_user)
  end


  def after_sign_out_path_for(resource_or_scope)
    root_path
  end
end

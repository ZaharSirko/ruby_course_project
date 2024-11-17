class ApplicationController < ActionController::Base
  allow_browser versions: :modern
  helper_method :current_cart
  before_action :authenticate_user!
  def current_cart
    @current_cart ||= Cart.find_or_create_by(user: current_user) if user_signed_in?
  end

  def after_sign_out_path_for(resource_or_scope)
    root_path
  end
end

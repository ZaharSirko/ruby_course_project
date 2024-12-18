class AdminsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin

  protect_from_forgery unless: -> { request.path.match?(/users\/auth/) }
  def update_role
    user = User.find(params[:id])
    if user.update(role: params[:role])
      redirect_to admins_users_path, notice: "Роль користувача змінено!"
    else
      redirect_to admins_users_path, alert: "Не вдалося змінити роль користувача."
    end
  end

  private

  def authorize_admin
    redirect_to root_path, alert: "У вас немає доступу до цієї сторінки" unless current_user.admin?
  end
end

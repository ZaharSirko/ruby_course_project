class Admins::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin_role

  def index
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admins_users_path, notice: "Користувача успішно оновлено."
    else
      render :edit
    end
  end

  private

  def check_admin_role
    unless current_user.admin?
      redirect_to root_path, alert: "Ви не маєте права керувати користувачами."
    end
  end

  def user_params
    params.require(:user).permit(:role)
  end
end

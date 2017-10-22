class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update]

  def edit; end

  def update
    @user.update(update_params)
    redirect_to root_path
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def update_params
    params[:user].permit(:name, :email)
  end
end

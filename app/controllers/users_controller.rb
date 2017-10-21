class UsersController < ApplicationController

  def edit
    @user = User.find(params[:id])
  end

  def update
    current_user.update(update_params)
    redirect_to root_path
  end

  private
  def update_params
    params[:user].permit(:name, :email)
  end
end

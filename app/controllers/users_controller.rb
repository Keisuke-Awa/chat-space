class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :edit, :update]
  before_action :set_user, only: [:edit, :update]

  def index
    @users = User.where('name like ?', "%#{params[:keyword]}%").limit(10)
    respond_to do |format|
      format.html
      format.json
    end
  end

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
    params.require(:user).permit(:name, :email)
  end
end

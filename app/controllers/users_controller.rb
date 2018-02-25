class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :edit, :update]
  before_action :set_user, only: [:edit, :update]

  def index
    begin
      @users = User.search(name_cont: search_params[:query]).result(distinct: true).limit(10)
      render json: @users, each_serializer: UserSerializer
    rescue => error
      render json: { errors: error }, status: 400
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

  def search_params
    params.permit(:query)
  end
end

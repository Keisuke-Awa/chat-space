class UsersController < ApplicationController

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user.update
  end
end

class ChatGroupsController < ApplicationController
  before_action :authenticate_user!

  def new
    @chat_group = ChatGroup.new
  end

  def create
    source = ChatGroup.new(chat_group_params)
    @chat_group = ChatGroupDecorator.decorate(source)
    if @chat_group.save
      redirect_to root_path, notice: 'グループを作成しました'
    else
      render :new
    end
  end

  def edit; end

  def update; end

  private
  def chat_group_params
    params.require(:chat_group).permit(:name, user_ids: [] )
  end

end

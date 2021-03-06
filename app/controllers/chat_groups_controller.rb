class ChatGroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_chat_group, only: %i(edit update)

  def index
    chat_groups = current_user.chat_groups.includes(:messages)
    @chat_groups = ChatGroupDecorator.decorate_collection(chat_groups)
  end

  def new
    @chat_group = ChatGroup.new
  end

  def create
    @chat_group = ChatGroup.new(chat_group_params).decorate
    if @chat_group.save
      redirect_to chat_group_messages_path(@chat_group), notice: 'グループを作成しました'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @chat_group.update(chat_group_params)
      redirect_to chat_group_messages_path(@chat_group), notice: 'グループを編集しました'
    else
      render :edit
    end
  end

  private
  def set_chat_group
    @chat_group = ChatGroup.find(params[:id]).decorate
  end

  def chat_group_params
    params.require(:chat_group).permit(:name, user_ids: [] )
  end

end

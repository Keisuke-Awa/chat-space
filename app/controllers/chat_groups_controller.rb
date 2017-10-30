class ChatGroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_chat_group, only: [:edit, :update]

  def index
    @chat_groups = ChatGroupDecorator.decorate_collection(current_user.chat_groups)
  end

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

  def update
    if @chat_group.update(chat_group_params)
      redirect_to root_path, notice: 'グループを編集しました'
    else
      render :edit
    end
  end

  private
  def set_chat_group
    source = ChatGroup.find(params[:id])
    @chat_group = ChatGroupDecorator.decorate(source)
  end

  def chat_group_params
    params.require(:chat_group).permit(:name, user_ids: [] )
  end

end

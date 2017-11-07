class MessagesController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]
  before_action :set_chat_group, only: [:index, :create]

  def index
    messages = @chat_group.messages.includes(:user).order(id: :asc)
    @messages = MessageDecorator.decorate_collection(messages)
    @message = Message.new
    chat_groups = current_user.chat_groups.includes(:messages)
    @chat_groups = ChatGroupDecorator.decorate_collection(chat_groups)
  end

  def create
    @message = Message.new(message_params)
    @message.chat_group_id = params[:chat_group_id]
    @message.user_id = current_user.id
    if @message.save
      redirect_to chat_group_messages_path(@chat_group), notice: 'メッセージが作成されました'
    else
      redirect_to chat_group_messages_path(@chat_group), alert: 'メッセージを入力してください'
    end
  end

  private
  def set_chat_group
    @chat_group = ChatGroup.find(params[:chat_group_id]).decorate
  end

  def message_params
    params.require(:message).permit(:body, :image)
  end

end


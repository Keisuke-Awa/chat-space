class MessagesController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]

  def index
    @chat_groups = ChatGroupDecorator.decorate_collection(current_user.chat_groups)
    @message = Message.new
  end

  def create
    @message = Message.new(message_params).decorate
    if @message.save
      @messages = @chat_group.messages.includes(:user).order('message.id ASC')
      redirect_to chat_group_messages_path(@chat_group), notice: 'メッセージが作成されました'
    else
      redirect_to chat_group_messages_path(@chat_group), alert: @message.error_messages
    end
  end

  private
  def set_chat_group
    @chat_group = ChatGroup.find(params[:chat_group_id]).decorate
  end

  def message_params
    params.require(:message).permit(:body, :image).merge(chat_group_id: params[:chat_group_id], user_id: current_user.id)
  end

end


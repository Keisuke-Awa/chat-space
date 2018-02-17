class MessagesController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]
  before_action :set_chat_group, only: [:index, :create]

  def index
    messages = @chat_group.messages.includes(:user)
    @messages = MessageDecorator.decorate_collection(messages)
    @message = Message.new
    chat_groups = current_user.chat_groups.includes(:messages)
    @chat_groups = ChatGroupDecorator.decorate_collection(chat_groups)
  end

  def create
    @message = Message.new(message_params)
    @message.chat_group = @chat_group.object
    @message.user = current_user
    respond_to do |format|
      if @message.save
        format.html { redirect_to chat_group_messages_path(@chat_group)  }
        format.json
      else
        redirect_to chat_group_messages_path(@chat_group), alert: 'メッセージを入力してください'
      end
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


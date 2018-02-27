class MessagesController < ApplicationController
  before_action :authenticate_user!, only: %i(index create)
  before_action :set_chat_group, only: %i(index create)

  def index
    messages = @chat_group.messages.includes(:user)
    @messages = MessageDecorator.decorate_collection(messages)
    @message = Message.new
    chat_groups = current_user.chat_groups.includes(:messages)
    @chat_groups = ChatGroupDecorator.decorate_collection(chat_groups)
    respond_to do |format|
      format.html
      format.json { render json: @messages}
    end
  end

  def create
    @message = Message.new(message_params)
    @message.chat_group = @chat_group
    @message.user = current_user
    begin
      @message.save!
      respond_to do |format|
        format.html { redirect_to chat_group_messages_path(@chat_group)  }
        format.json { render json: @message}
      end
    rescue => error
      render json: { errors: error }, status: 400
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


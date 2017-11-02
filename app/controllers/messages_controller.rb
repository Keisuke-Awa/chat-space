class MessagesController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]

  def index
    @chat_group = ChatGroup.find(params[:chat_group_id])
    @chat_groups = ChatGroupDecorator.decorate_collection(current_user.chat_groups)
    @message = Message.new
  end

  def create; end

  private
  def message_params; end

end


class MessagesController < ApplicationController
  before_action :authenticate_user!, only: [:index]

  def index
    @chat_groups = ChatGroupDecorator.decorate_collection(current_user.chat_groups)
  end

  def create; end

  private
  def set_sidebar; end

  def message_params; end
end


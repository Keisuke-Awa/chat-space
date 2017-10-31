class MessagesController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]

  def index
    @chat_groups = ChatGroupDecorator.decorate_collection(current_user.chat_groups)
  end

  def create; end

  private
  def message_params; end

end


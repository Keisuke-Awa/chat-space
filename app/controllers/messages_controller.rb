class MessagesController < ApplicationController
  before_action :authenticate_user!, only: [:index]

  def index
    @chat_groups = current_user.chat_groups
  end

end


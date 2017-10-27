class ChatGroupsController < ApplicationController

  def new
    @chat_group = ChatGroup.new
  end

  def create
    chat_group = ChatGroup.new(chat_group_params)
    respond_to do |format|
      if chat_group.save
        format.html { redirect_to root_path, notice: 'グループを作成しました' }
      else
        format.html { redirect_to root_path, alert: '作成に失敗しました' }
      end
    end
  end

  def edit; end

  def update; end

  private
  def chat_group_params
    params.require(:chat_group).permit(:name, user_ids: [] )
  end

end

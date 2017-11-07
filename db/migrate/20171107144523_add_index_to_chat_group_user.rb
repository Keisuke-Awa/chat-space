class AddIndexToChatGroupUser < ActiveRecord::Migration[5.0]
  def change
    add_index :chat_group_users, [:chat_group_id, :user_id], unique: true
  end
end

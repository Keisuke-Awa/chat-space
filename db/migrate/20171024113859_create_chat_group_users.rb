class CreateChatGroupUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :chat_group_users do |t|
      t.references :user, foreign_key: true
      t.references :chat_group, foreign_key: true
      t.timestamps null: false, default: -> { 'NOW()' }
    end
    add_index :chat_group_users, [:chat_group_id, :user_id], unique: true
  end
end

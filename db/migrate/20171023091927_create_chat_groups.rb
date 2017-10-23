class CreateChatGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :chat_groups do |t|
      t.string :name, null: false, default: ""
      t.timestamps null: false, default: -> { 'NOW()' }
    end

    add_index :chat_groups, :name, unique: true
  end
end

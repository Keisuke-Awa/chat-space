class ChatGroup < ApplicationRecord
  has_many :users, through: :chat_group_users
  has_many :chat_group_users
  accepts_nested_attributes_for :chat_group_users
end

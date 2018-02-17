class MessageSerializer < ActiveModel::Serializer
  attributes :id, :body, :image, :user_id, :chat_group_id
  has_one :user
  has_one :chat_group
end

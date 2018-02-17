class MessageSerializer < ActiveModel::Serializer
  attributes :id, :body, :image, :user_id, :created_at
  has_one :user
end

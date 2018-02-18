class MessageSerializer < ActiveModel::Serializer
  attributes :id, :body, :image, :user_id, :created_at
  has_one :user

  def created_at
    object.created_at.strftime('%Y年%m月%d日 %H:%M')
  end

end

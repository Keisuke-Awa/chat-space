class MessageSerializer < ActiveModel::Serializer
  attributes  :body, :created_at, :created_at_time, :image_url, :user_id, :user_name

  def created_at_time
    object.created_at.strftime('%Y年%m月%d日 %H:%M')
  end

  def image_url
    object.image&.url.to_s
  end

  def user_name
    object.user.name.to_s
  end

end

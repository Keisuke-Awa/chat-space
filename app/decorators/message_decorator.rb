class MessageDecorator < Draper::Decorator
  delegate_all

  def user_name
    object.user&.name.to_s
  end

  def created_at_time
    object.created_at.strftime('%Y年%m月%d日 %H:%M')
  end

  def body
    object.body.to_s
  end

  def image
    object.image.present? ? object.image : ''
  end

end

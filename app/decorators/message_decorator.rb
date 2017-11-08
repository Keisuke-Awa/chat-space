class MessageDecorator < Draper::Decorator
  delegate_all

  def user_name
    object.user.name
  end

  def created_at_time
    object.created_at.strftime('%Y年%m月%d日 %H:%M')
  end

end
class ChatGroupDecorator < Draper::Decorator
  delegate_all

  def name
    object.name
  end

  def errors_count
    "#{ object.errors.count }件のエラーが発生しました。"
  end

  def full_messages
    object.errors.full_messages
  end

end

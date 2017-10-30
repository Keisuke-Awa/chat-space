class ChatGroupDecorator < Draper::Decorator
  delegate_all

  def name
    object.name
  end

  def errors_count
    object.errors.count
  end

  def error_messages
    object.errors.full_messages
  end

end

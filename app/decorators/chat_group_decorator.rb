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

  def latest_message
    if object.messages.present?
      object.messages.last.body.present? ? object.messages.last.body : '画像が投稿されています'
    else
      'まだメッセージがありません'
    end
  end
end

class ChatGroupDecorator < Draper::Decorator
  delegate_all

  def name
    object.name
  end

  def users
    object.users
  end

  def errors_count
    object.errors.count
  end

  def error_messages
    object.errors.full_messages
  end

  def latest_message
    return 'まだメッセージがありません' unless object.messages.present?
    object.messages.last.body.present? ? object.messages.last.body : '画像が投稿されています'
  end
end

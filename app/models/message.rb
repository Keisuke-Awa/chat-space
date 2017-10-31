# == Schema Information
#
# Table name: messages
#
#  id            :integer          not null, primary key
#  body          :text(65535)
#  image         :string(255)
#  user_id       :integer
#  chat_group_id :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Message < ApplicationRecord
  belongs_to :chat_group
  belongs_to :user

  validates :body_or_image, presence: true

  private
  def body_or_image
    body.presence or image.presence
  end
end

# == Schema Information
#
# Table name: messages
#
#  id            :integer          not null, primary key
#  body          :text(65535)
#  image         :string(255)      default("")
#  user_id       :integer
#  chat_group_id :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Message < ApplicationRecord
  belongs_to :chat_group
  belongs_to :user

  mount_uploader :image, ImageUploader

  validates :body_or_image, presence: true
  validates :user_id, presence: true, numericality: { only_integer: true }
  validates :chat_group_id, presence: true, numericality: { only_integer: true }

  scope :new_records, ->(id:) { where("id > ?", id) }

  private
  def body_or_image
    body.presence or image.presence
  end
end

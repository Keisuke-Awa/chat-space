# == Schema Information
#
# Table name: chat_groups
#
#  id         :integer          not null, primary key
#  name       :string(255)      default(""), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ChatGroup < ApplicationRecord
  has_many :chat_group_users
  has_many :users, through: :chat_group_users
  has_many :messages
  accepts_nested_attributes_for :users, allow_destroy: true

  validates :name, presence: true, uniqueness: true
end

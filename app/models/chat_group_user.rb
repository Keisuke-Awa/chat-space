# == Schema Information
#
# Table name: chat_group_users
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  chat_group_id :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class ChatGroupUser < ApplicationRecord
  belongs_to :user
  belongs_to :chat_group
end

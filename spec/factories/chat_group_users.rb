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

FactoryBot.define do

  factory :chat_group_user do
    association :user,       factory: :user
    association :chat_group, factory: :chat_group
  end

end

FactoryBot.define do

  factory :chat_group_user do
    association :user,       factory: :user
    association :chat_group, factory: :chat_group
  end

end
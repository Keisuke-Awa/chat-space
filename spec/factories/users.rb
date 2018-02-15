# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  name                   :string(255)      default(""), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

require 'faker'

FactoryBot.define do

  factory :user do
    name                     { Faker::Name.first_name }
    email                    { Faker::Internet.email }
    password                 { Faker::Internet.password(8) }

    after(:create) do |user|
      create(:chat_group_user, user: user, group: create(:group))
    end
  end

end

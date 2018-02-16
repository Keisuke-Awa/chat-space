# == Schema Information
#
# Table name: chat_groups
#
#  id         :integer          not null, primary key
#  name       :string(255)      default(""), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'faker'

FactoryBot.define do

  factory :chat_group do
    name                     { Faker::Company.name }
  end

end

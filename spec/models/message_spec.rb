require 'rails_helper'
describe Message do
  describe '#create' do

    it "is valid with a body, user_id, chat_group_id" do
      message = build(:message, image: nil)
      expect(message).to be_valid
    end

    it "is valid with a image, user_id, chat_group_id" do
      message = build(:message, body: nil)
      expect(message).to be_valid
    end

    it "is valid with a body, image, user_id, chat_group_id" do
      message = build(:message)
      expect(message).to be_valid
    end

    it "is invalid without a body and image" do
      user = build(:message, body: "", image: "")
      user.valid?
      expect(user.errors[:body_or_image]).to include("を入力してください")
    end

  end
end

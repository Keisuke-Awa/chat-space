require 'rails_helper'
describe Message do
  describe '#create' do

    it "is valid with a body" do
      message = build(:message, image: nil)
      expect(message).to be_valid
    end

    it "is valid with a body" do
    end

    it "is valid with a body" do
    end

    it "is valid with a body" do
    end

  end
end

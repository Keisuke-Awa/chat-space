require 'rails_helper'

describe MessagesController do
  let(:user) { create(:user) }
  let!(:chat_group) { create(:chat_group, users:[user]) }


  describe 'GET #index' do
    context "when user signed in" do
      before do
        login_user user
      end

      it "assigns the requested chat_group to @chat_group" do
        get :index, chat_group_id: chat_group.id
        expect(assigns(:chat_group)).to eq chat_group
      end

      it "assigns the requested chat_groups to @chat_groups" do

      end

      it "assigns the requested messages to @messages" do
      end

      it "renders the :index template " do
        get :index, chat_group_id: chat_group.id
        expect(response).to render_template :index
      end

    end
  end

end

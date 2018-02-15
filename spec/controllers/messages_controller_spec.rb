require 'rails_helper'

describe MessagesController do
  let(:user) { create(:user) }


  describe 'GET #index' do
    let!(:chat_groups) { user.chat_groups }
    let!(:chat_group) { chat_groups.first }
    # let!(:messages) { create_list(:message, 5, chat_group: chat_group) }
    context "when user signed in" do
      before do
        login_user user
        get :index, params: { chat_group_id: chat_group.id }
      end

      it "assigns the requested chat_group to @chat_group" do
        expect(assigns(:chat_group)).to eq chat_group
      end

      it "@chat_group is decorated with ChatGroupDecorator" do
        expect(assigns(:chat_group)).to be_decorated_with ChatGroupDecorator
      end

      it "assigns the requested messages to @messages" do
        expect(assigns(:messages)).to eq messages
      end

      it "@messages are decorated with MessageDecorator" do
        expect(assigns(:messages)).to be_decorated_with MessageDecorator
      end

      it "@messages are decorated with MessageDecorator" do
        expect(assigns(:chat_groups)).to be_decorated_with ChatGroupDecorator
      end

      it "assigns a new message to @message" do
        expect(assigns(:message)).to be_a_new Message
      end

      it "renders the :index template " do
        expect(response).to render_template :index
      end

    end

    context "when user not signed in" do
      it "redirect to new_user_session_path " do
        get :index, params: { chat_group_id: chat_group.id }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'GET #create' do
    let!(:chat_group) { create(:chat_group) }
    subject {
      Proc.new { post :create, params: { chat_group_id: chat_group.id, message: message_params } }
    }
    context "when user signed in" do
      before do
        login_user user
      end

      context "with valid message attributes" do
        let(:message_params) { attributes_for(:message) }

        it "assigns the requested chat_group to @chat_group and to be decorated" do
          subject.call
          expect(assigns(:chat_group)).to eq chat_group
          expect(assigns(:chat_group)).to be_decorated
        end

        it "creates a new message" do
          expect{
            subject.call
          }.to change(Message, :count).by(1)
        end

        it "redirects to the :index template with flash notice" do
          subject.call
          expect(response).to redirect_to chat_group_messages_path(chat_group)
          expect(flash[:notice]).to eq('メッセージが作成されました')
        end
      end

      context "with invalid message attributes" do
        let(:message_params) { attributes_for(:message, body: nil, image: nil) }

        it "assigns the requested chat_group to @chat_group and to be decorated" do
          subject.call
          expect(assigns(:chat_group)).to eq chat_group
          expect(assigns(:chat_group)).to be_decorated
        end

        it "cannot create a new message" do
          expect {
            subject.call
          }.to change(Message, :count).by(0)
        end

        it "redirects to the :index template with flash alert" do
          subject.call
          expect(response).to redirect_to chat_group_messages_path(chat_group)
          expect(flash[:alert]).to eq('メッセージを入力してください')
        end
      end

    end

    context "when user not signed in" do
      let(:message_params) { attributes_for(:message) }
      it "redirect to new_user_session_path " do
        subject.call
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

end

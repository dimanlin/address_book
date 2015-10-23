require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { FactoryGirl.create(:user) }

  describe '.index' do
    before do
      get :index
    end

    it 'respond user' do
      expect(assigns[:users]).to eq([user])
    end
  end

  describe '.edit' do
    before do
      get :edit, id: user.id
    end

    it 'respond user' do
      expect(assigns[:user]).to eq(user)
    end
  end

  describe '.update' do
    before do
      get :update, id: user.id, user: { first_name: 'new_first_name',
                                        last_name: 'new_last_name',
                                        emails: ['email_1@example.com', 'email_2@example.com'],
                                        phone_numbers: ['8(926)123-45-67', '8(926)123-45-68']}
    end

    it 'respond user' do
      expect(assigns[:user].first_name).to eq('new_first_name')
      expect(assigns[:user].last_name).to eq('new_last_name')
      expect(assigns[:user].emails).to eq(['email_1@example.com', 'email_2@example.com'])
      expect(assigns[:user].phone_numbers).to eq(['8(926)123-45-67', '8(926)123-45-68'])
    end
  end

  describe '.new' do
    before do
      get :new
    end

    it 'respond user' do
      expect(assigns[:user].phone_numbers).to eq([''])
      expect(assigns[:user].emails).to eq([''])
    end
  end

  describe '.create' do
    context 'success' do
      before do
        post :create, user: { first_name: 'first_name',
                             last_name: 'last_name',
                             emails: ['email_1@example.com', 'email_2@example.com'],
                             phone_numbers: ['8(926)123-45-67', '8(926)123-45-68']}
      end

      it 'check attributes' do
        expect(User.count).to eq(1)
        expect(User.take.first_name).to eq('first_name')
        expect(User.take.last_name).to eq('last_name')
        expect(User.take.emails).to eq(['email_1@example.com', 'email_2@example.com'])
        expect(User.take.phone_numbers).to eq(['8(926)123-45-67', '8(926)123-45-68'])
      end
    end

    context 'fail' do
      before do
        post :create, user: { first_name: 'first_name',
                              last_name: 'last_name',
                              emails: [],
                              phone_numbers: ['8(926)123-45-67', '8(926)123-45-68']}
      end

      it 'render template' do
        expect(response).to render_template(:new)
      end
    end
  end

  describe '.destroy' do
    before do
      @user = FactoryGirl.create(:user)
    end

    it 'delete user' do
      expect{delete :destroy, id: @user.id}.to change{User.count}.from(1).to(0)
    end
  end

  describe '.show' do
    before do
      get :show, id: user.id
    end

    it 'respond user' do
      expect(assigns[:user]).to eq(user)
    end
  end
end
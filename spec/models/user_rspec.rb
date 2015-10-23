require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryGirl.create(:user) }
  describe '.full_name' do
    it do
      expect(user.full_name).to eq("#{user.first_name} #{user.last_name}")
    end
  end

  describe 'private methods' do
    describe '.remove_empty_values!' do
      before do
        user.emails << ''
        user.phone_numbers << ''
        user.send(:remove_empty_values!)
      end

      it do
        expect(user.emails).to_not include('')
        expect(user.phone_numbers).to_not include('')
      end
    end
  end

  describe '.validate_full_name' do
    context 'if last_name was changed and we alredy ahve user with same last_name and first_name' do
      before do
        user.last_name = 'new_last_name'
        user.first_name = 'new_first_name'
        @user_2 = FactoryGirl.create(:user, last_name: user.last_name, first_name: user.first_name)
        user.send(:validate_full_name)
      end

      it 'get validation error for user' do
        expect(user.errors.messages[:full_name]).to eq(["Sorry but you already have that user"])
      end
    end
  end

  describe '.uniq_emails' do
    before do
      user.emails = ["a@a.com", "a@a.com"]
      user.send(:uniq_emails)
    end

    it 'get uniq emails' do
      expect(user.emails).to eq(['a@a.com'])
    end
  end

  describe '.uniq_phone_numbers' do
    before do
      user.phone_numbers = ["8(926)123-45-67", "8(926)123-45-67"]
      user.send(:uniq_phone_numbers)
    end

    it 'get uniq emails' do
      expect(user.phone_numbers).to eq(['8(926)123-45-67'])
    end
  end

  describe 'clear_phone_numbers' do
    before do
      user.phone_numbers = ["8(926)123-45-61"]
      user.send(:clear_phone_numbers)
    end

    it do
      expect(user.phone_numbers).to eq(['89261234561'])
    end
  end
end

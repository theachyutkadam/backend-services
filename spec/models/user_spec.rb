require 'rails_helper'

RSpec.describe User, type: :model do
  context '#authenticate' do
    it 'should login successfully' do
      user = build(:user)
      user.save
      expect(user).to be_valid
    end

    it 'should give an error if email is empty' do
      user = build(:user, email: "")
      user.save
      expect(user.errors.messages[:email].first).to eq("can't be blank")
    end

    it 'should give an error if email is duplicate' do
      create(:user)
      user = build(:user)
      user.save
      expect(user.errors.messages[:email].first).to eq("has already been taken")
    end

    it 'should give an error if password is empty' do
      user = build(:user, password: "")
      user.save
      expect(user.errors.messages[:password].first).to eq("can't be blank")
    end
  end
end

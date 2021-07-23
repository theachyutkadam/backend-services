require 'rails_helper'

RSpec.describe Customer, type: :model do
  context '#validation' do
    it 'should give an error if first_name is empty' do
      customer = build(:customer, first_name: "")
      customer.save
      expect(customer.errors.messages[:first_name].first).to eq("can't be blank")
    end

    it 'should give an error if last_name is empty' do
      customer = build(:customer, last_name: "")
      customer.save
      expect(customer.errors.messages[:last_name].first).to eq("can't be blank")
    end

    it 'should give an error if conact is empty' do
      create(:customer)
      customer = build(:customer, contact: '')
      customer.save
      expect(customer.errors.messages[:contact].first).to eq("can't be blank")
    end
  end
end

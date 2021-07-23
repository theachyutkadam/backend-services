class Customer < ApplicationRecord
  validates :first_name, :last_name, :contact, presence: true
end
class User < ApplicationRecord
  validates :email, :password, presence: true
  validates :email, uniqueness: true

  def self.authenticate(email, password)
    User.find_by(email: email, password: password)
  end
end

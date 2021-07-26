class User < ApplicationRecord
  validates :email, :password, presence: true
  validates :email, uniqueness: true

  def self.authenticate(email, password)
    User.find_by(email: email, password: password)
  end

  def generate_token
    user_details = {email: email, user_id: id}
    encrypt(user_details.to_json, "user")
  end

  def encrypt(str, key)
    cipher = OpenSSL::Cipher.new('RC4')
    cipher.key = OpenSSL::Digest.digest('md5', key)
    Base64.encode64(cipher.update(str) + cipher.final)
  end
end

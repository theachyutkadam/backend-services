class ApplicationController < ActionController::API
  before_action :authenticate_user

  def authenticate_user
    auth_token = request.headers['X-AUTH-TOKEN']
    user_details = JSON.parse(decrypt(auth_token, 'user'))
    @user = User.find_by(email: user_details['email'])
    if @user.id == session[:user_id]
    else
      if session[:user_id].present?
        response = {message: "Access denied"}
        render json: response, status: 401
      else
        response = {message: "User not found"}
        render json: response, status: 401
      end
    end
  end

  def decrypt(encrypted_string, key)
    decipher = OpenSSL::Cipher.new('RC4')
    decipher.key = OpenSSL::Digest.digest('md5', key)
    decipher.update(Base64.decode64(encrypted_string)) + decipher.final
  end

  def current_user
    # @user
  end

end

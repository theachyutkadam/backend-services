class ApplicationController < ActionController::API
  before_action :authenticate_user

  def authenticate_user
    auth_token = request.headers['X-AUTH-TOKEN']
    begin
      user_details = JSON.parse(decrypt(auth_token, 'user'))
      @user = User.find_by(email: user_details['email'])
    rescue Exception => e
      Rails.logger.info "Authentication error --> Message: #{e.message}"
      # return_error 500, false, 'Oops. Something went wrong, please try again after some time.', []
      response = {message: "Oops. Something went wrong, please try again after some time."}
      render json: response, status: 500
    end

    if @user
      if Redis.new.keys("#{@user.id}").empty?
        response = {message: "User sign out already"}
        render json: response, status: 401
      else
        if auth_token == Redis.new.get("#{@user.id}").chomp
        else
          response = {message: "Access denied"}
          render json: response, status: 401
        end
      end
    else
      response = {message: "User not found"}
      render json: response, status: 401
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

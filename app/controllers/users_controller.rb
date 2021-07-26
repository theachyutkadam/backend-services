class UsersController < ApplicationController
  skip_before_action :authenticate_user

  def sign_in
    @user = User.authenticate params[:user][:email], params[:user][:password]
    if @user
      encrypt_token = @user.generate_token

      response.headers["X-AUTH-TOKEN"] = encrypt_token
      redis_token = Redis.new()
      redis_token.set(@user.id, encrypt_token)

      response = {message: 'User successfully sign in.'}
      render json: response, status: 200
    else
      response = {message: 'Invalid username and password.'}
      render json: response, status: 401
    end
  end

  def sign_up
    puts "------------------sign_up"
    puts params
  end

  def sign_out
    auth_token = request.headers['X-AUTH-TOKEN']
    user_details = JSON.parse(decrypt(auth_token, 'user'))
    @user = User.find_by(email: user_details['email'])

    Redis.new.del("#{@user.id}")
    response = {message: 'User successfully sign out.'}
    render json: response, status: 200
  end

  def decrypt(encrypted_string, key)
    decipher = OpenSSL::Cipher.new('RC4')
    decipher.key = OpenSSL::Digest.digest('md5', key)
    decipher.update(Base64.decode64(encrypted_string)) + decipher.final
  end

end

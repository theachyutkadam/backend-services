class UsersController < ApplicationController
  skip_before_action :authenticate_user

  def sign_in
    @user = User.authenticate params[:user][:email], params[:user][:password]
    if @user
      session[:user_id] = @user.id
      user_details = {email: @user.email, user_id: @user.id}
      response.headers["X-AUTH-TOKEN"] = encrypt(user_details.to_json, "user")
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
    puts "------------------"
  end

  def sign_out
    session[:user_id] = nil
    response = {message: 'User successfully sign out.'}
    render json: response, status: 200
  end

  def encrypt(str, key)
    cipher = OpenSSL::Cipher.new('RC4')
    cipher.key = OpenSSL::Digest.digest('md5', key)
    Base64.encode64(cipher.update(str) + cipher.final)
  end
end

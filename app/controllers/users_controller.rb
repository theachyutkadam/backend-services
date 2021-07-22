class UsersController < ApplicationController
  skip_before_action :authenticate_user

  def sign_in
    @user = User.authenticate params[:user][:email], params[:user][:password]
    if @user
      session[:user_id] = @user.id
      render json: {message: 'User successfully sign in.', status: 200}
    else
      render json: {message: 'Invalid username and password.', status: 401}
    end
  end

  def sign_up
    puts "------------------sign_up"
    puts params
    puts "------------------"
  end
end

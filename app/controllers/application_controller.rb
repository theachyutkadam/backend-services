class ApplicationController < ActionController::API
  before_action :authenticate_user

  def authenticate_user
    @user = User.find_by(id: session[:user_id])
  end

  def current_user
    @user
  end

end

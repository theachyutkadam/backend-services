require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "POST /sign_in" do
    # it "should successfully sign_in" do
    #   user = build(:user)
    #   post "/sign_in", params: {user: {email: "user.email", password: user.password}}
    #   expect(response).to have_http_status(200)
    # end

    it "should sign_in failed with invalid email" do
      post "/sign_in", params: {user: {email: "demo@demo.com", password: '123456'}}
      expect(response).to have_http_status(401)
    end
  end

  # describe "POST /sign_up" do
    # it "returns http success" do
      # post "/users/sign_up"
      # expect(response).to have_http_status(:success)
    # end
  # end

end

require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  test "logging in with a user" do
    request.env["devise.mapping"] = Devise.mappings[:user]
    user = FactoryGirl.create(:user, :username => "frank", :password => "juice", :password_confirmation => "juice")
    post :create, {:user => {:username => "frank", :password => "juice"}}
    res = JSON.parse(response.body)
    assert res["success"], "User successfully logged in"
    assert warden.authenticated?(:user), "Warden confirms login"
  end

  test "failing a login with a user" do
    request.env["devise.mapping"] = Devise.mappings[:user]
    user = FactoryGirl.create(:user, :username => "frank", :password => "juice", :password_confirmation => "juice")
    post :create, {:user => {:username => "frank", :password => "juicy"}}
    assert_response 401, "user was unable to login"
    assert_equal false, warden.authenticated?(:user), "Warden confirms login was not successful"
    # TODO add in a test for the failure message -- for 
    # some reason parsing the response wasn't working for me here
  end
end

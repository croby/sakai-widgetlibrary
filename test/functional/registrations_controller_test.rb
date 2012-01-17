require 'test_helper'

class RegistrationsControllerTest < ActionController::TestCase
  test "register a user" do
    request.env["devise.mapping"] = Devise.mappings[:user]
    post :create, {
      :user => {
        :first_name => "Jackson",
        :last_name => "Teller",
        :email => "jax@sakaiproject.invalid",
        :username => "jax",
        :password => "test",
        :password_confirmation => "test"
      }
    }
    p @response
    assert_response 200, "successfully registered a user"
  end
end

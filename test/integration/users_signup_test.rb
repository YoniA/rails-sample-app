require "test_helper"

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: {user: { name: "",
                                        email: "invalid@foo.com",
                                        password: "foo",
                                        password_confirmation: "bar"
                                      }
                                }
        
    end
    assert_template 'users/new' # re-render users#new upon failed submission
    assert_select 'div#error-explanation'
  end
end

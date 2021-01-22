require "test_helper"

class UserTest < ActiveSupport::TestCase
  
  def setup
    @user = User.new(name: "Example user", email: "example@user.com", password: "foobar", password_confirmation: "foobar")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = "    "
    assert_not @user.valid?
  end

  test "name should not be too long" do 
    @user.name = "a"*51
    assert_not @user.valid?
  end

  test "email should not be too long" do 
    @user.email = "a"*247 + "@user.com"
    puts @user.email.length
    assert_not @user.valid?
  end

  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM a_US-eR@foo.bar.org first.last@goo.hp
                           alice+bob@baz.cn]
    valid_addresses.each do |address|
      @user.email = address
      assert @user.valid?, "#{address.inspect} should be valid"
    end 
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com USER_at_foo.COM a_US-eR@foo. 
                            first.last@goo_baz.hp alice+bob@bar+baz.cn foo@bar..com]
    invalid_addresses.each do |address|
      @user.email = address
      assert_not @user.valid?, "#{address.inspect} should be invalid"
    end 
  end

  test "email address should be unique" do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end

  test "email address should be saved downcase" do
    mixed_case_email = "John@DOE.com"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test "password should not be blank" do
    @user.password = @user.password_confirmation =  " " * 6
    assert_not @user.valid?
  end

  test "password should have a minimal length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end
end

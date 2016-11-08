require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  def setup
    @user = users(:rhys)
  end


  test "should be valid" do
    assert @user.valid?
  end


  test "email should be present" do
    @user.email = "     "
    assert_not @user.valid?
  end


  test "email should not be too long" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end


  test "A standard password is valid" do
    @user.password = "password"
    assert @user.valid?
  end


  test "password can't be blank" do
    @user.password = " " * 8
    assert_not @user.valid?
  end


  test "email addresses should be saved as lower-case" do
    mixed_case_email = "Foo@RAILS.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end


  test "email should be unique" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end


  test "email addresses should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end


  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "associated microposts should be destroyed" do
    @user.save
    @user.posts.create!(content: "Lorem ipsum")
    puts @user.posts
    assert_difference 'Post.count', -1 do
      @user.destroy
    end
  end

end

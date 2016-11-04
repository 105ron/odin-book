require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

	def setup
    @base_title = "Odin-Book"
  end

  test "should get root" do
    get '/'
    assert_response :success
    assert_select "title", "Welcome | #{@base_title}"
  end

end

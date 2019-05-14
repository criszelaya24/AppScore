require 'test_helper'

class SelectorControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get selector_index_url
    assert_response :success
  end

end

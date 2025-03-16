require "test_helper"

class GuessesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get guesses_create_url
    assert_response :success
  end
end

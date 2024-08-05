require "test_helper"

class IssueTest < ActionDispatch::IntegrationTest
  test "a user can visit the new issue page" do
    login_as users(:ife)
    get new_issue_url
    assert_response :success
  end
end

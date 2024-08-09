require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "user has signed up through github omniauth" do
    user = User.new(provider: "github")
    assert(user.signed_in_with_github?, true)
  end
end

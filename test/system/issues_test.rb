require "application_system_test_case"

class IssuesTest < ApplicationSystemTestCase

  test "can visit the landing page" do
    visit root_url
    assert_selector "h1", text: "Find solutions for your issues"
  end

  test "creating an issue with a signed in user" do
    login_as users(:ife)
    visit "issues/new"

    fill_in "Title", with: "Test issue"
    fill_in "Error message", with: "This is a test issue"
    click_on "LET'S SOLVE IT!"

    assert_text "Test issue"
    assert_selector ".title-with-votes", count: 1
  end

  test "checking the presence of a created issue" do
    visit issues_url
    assert_selector ".issues-card", count: 1
  end
end

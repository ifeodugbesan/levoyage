require "test_helper"

class IssueFlowsTest < ActionDispatch::IntegrationTest
  test "can see the landing page" do
    get root_url
    assert_response :success
    assert_select "h1", text: "Find solutions for your issues"
  end

  test "can see the issues index" do
    get issues_url
    assert_response :success
  end

  test "can see the issues show page" do
    issue = issues(:one)
    get issue_url(issue)
    assert_response :success
  end

  test "can see the issues new page" do
    login_as (users(:ife))
    get new_issue_url
    assert_select "h3", text: "Solved an issue?"
    assert_response :success
  end

  test "can create an issue" do
    login_as (users(:ife))
    get new_issue_url
    assert_response :success
    post issues_url, params: { issue: { title: "This is an issue created in a test", error_message: "Failed to created this issue", user: users(:ife) } }
    assert_response :redirect
    follow_redirect!
    assert_response :success
  end

  test "can see the resources index" do
    get resources_url
    assert_response :success
  end

  test "can create a resource" do
    login_as (users(:ife))
    get new_resource_url
    assert_response :success
    post resources_url, params: { resource: { title: "This is a resource created in a test", link: "https://www.google.com", description: "This is a description of the resource", user: users(:ife) } }
    assert_response :redirect
    follow_redirect!
    assert_response :success
  end
end

require "test_helper"

class User::IdeasControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get user_ideas_new_url
    assert_response :success
  end

  test "should get index" do
    get user_ideas_index_url
    assert_response :success
  end

  test "should get show" do
    get user_ideas_show_url
    assert_response :success
  end

  test "should get edit" do
    get user_ideas_edit_url
    assert_response :success
  end
end

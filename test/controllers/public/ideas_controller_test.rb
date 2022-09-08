require "test_helper"

class Public::IdeasControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get public_ideas_new_url
    assert_response :success
  end

  test "should get index" do
    get public_ideas_index_url
    assert_response :success
  end

  test "should get show" do
    get public_ideas_show_url
    assert_response :success
  end

  test "should get edit" do
    get public_ideas_edit_url
    assert_response :success
  end
end

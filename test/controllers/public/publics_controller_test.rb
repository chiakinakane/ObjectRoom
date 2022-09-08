require "test_helper"

class Public::PublicsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_publics_index_url
    assert_response :success
  end

  test "should get show" do
    get public_publics_show_url
    assert_response :success
  end

  test "should get edit" do
    get public_publics_edit_url
    assert_response :success
  end
end

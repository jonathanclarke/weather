require 'test_helper'

class SearchesControllerTest < ActionController::TestCase
  test "GET searches#new" do
    get :new
    assert_response :success
    assert_template :application
  end

  test "POST searches#create" do
    post :create, :search => {:zipcode => 30068}
    assert_response 302
  end

end

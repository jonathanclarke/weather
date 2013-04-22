require 'test_helper'

class SearchTest < ActionDispatch::IntegrationTest
  test "search for valid postcode" do
    get "/"
    assert_response :success

    post_via_redirect "/searches", :search => {:zipcode => 30068}
    assert_equal '/', path
 
    assert_response :success
    assert assigns(:results)
    assert response.body.include?("Success!")
    assert response.body.include?("<td>30068</td>")
    assert response.body.include?("<td>Marietta</td>")
    assert response.body.include?("<td>GA</td>")

  end
end

require 'test_helper'

class WeatherUndergroundTest < ActiveSupport::TestCase

  def setup 
    @wu = WeatherUnderground::Conditions.new
    @valid_response = @wu.find_by_zipcode(30068)
    @invalid_response = @wu.find_by_zipcode(66666)
  end

  test "find_by_zipcode returns an expected response for zip 30068" do
    assert_not_nil @valid_response
    assert @valid_response.include?("Marietta")
    assert @valid_response.include?("Georgia")
    assert @valid_response.include?("temp_f")
  end

  test "find_by_zipcode returns an city + state + temp response for zip 30068" do
    assert @valid_response.include?("Marietta")
    assert @valid_response.include?("Georgia")
    query = MultiJson.decode(@valid_response, :symbolize_keys => true)
    assert_not_nil query[:current_observation][:temp_f]
    assert_equal query[:current_observation][:display_location][:city], "Marietta"
    assert_equal query[:current_observation][:display_location][:state_name], "Georgia"
  end

  test "find_by_zipcode returns an expected response for zip 66666" do
    assert_not_nil @invalid_response
  end

  test "An unknown zipcode should have an error description" do
    assert_not_nil @invalid_response
    assert @invalid_response.include?("No cities match your search query")
  end
end

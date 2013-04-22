require 'test_helper'

class SearchTest < ActiveSupport::TestCase

  test "search should not be valid on init" do
    assert !Search.new.valid?
  end
  
  test "search should be valid once there is a valid postcode" do
    assert Search.new(:zipcode => 30060).valid?    
    assert Search.new(:zipcode => "12345").valid?
    assert Search.new(:zipcode => 12345).valid?
  end

  test "search should not be valid once there is an invalid postcode" do
    assert !Search.new(:zipcode => 1234).valid?
    assert !Search.new(:zipcode => 123456).valid?
    assert !Search.new(:zipcode => "abc1234").valid?
    assert !Search.new(:zipcode => "a1234").valid?
  end
  
  test "search should have a zipcode present" do
    search = Search.new(:zipcode => nil)
    assert !search.valid?
    assert search.invalid?(:zipcode)
    assert search.errors[:zipcode].any? { |s| s.include?("can't be blank") }
    search.zipcode = "12345"
    assert !search.invalid?(:zipcode)
  end


  test "search should have a numeric zipcode" do
    search = Search.new(:zipcode => "abc132")
    assert !search.valid?
    assert search.invalid?(:zipcode)
    assert search.errors[:zipcode].any? { |s| s.include?("invalid zip code format : must be a number") }
    search.zipcode = "12345"
    assert !search.invalid?(:zipcode)
  end


  test "search should have a zipcode present that is 5 digits" do
    search = Search.new(:zipcode => "1324")
    assert !search.valid?
    assert search.invalid?(:zipcode)
    assert search.errors[:zipcode].any? { |s| s.include?("invalid zip code format : must be 5 digits") }
    search.zipcode = 12345
    assert !search.invalid?(:zipcode)    
  end

end

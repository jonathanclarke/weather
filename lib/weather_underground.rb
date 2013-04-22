require 'net/http'

module WeatherUnderground

  API_KEY = "ed044d75b91fb500"

  class Conditions

    def initialize
    end

    def find_by_zipcode(zipcode)
      begin
        base_url = "http://api.wunderground.com/api/#{ API_KEY }/conditions/q/#{ zipcode }.json"
        Net::HTTP.get(URI.parse(base_url))
      rescue Exception => e
        puts e.backtrace
      end
    end

  end

end

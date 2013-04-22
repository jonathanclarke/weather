require 'multi_json'

class Search < ActiveRecord::Base

  validates_presence_of :zipcode
  validates_numericality_of :zipcode, :message => ": invalid zip code format : must be a number"
  validates_length_of :zipcode, :minimum => 5, :maximum => 5, :message => ": invalid zip code format : must be 5 digits"


  validate :ensure_zipcode_is_real, :before => :create, :message => ": invalid zip code format : zipcode not found"


  def self.pull_weather_data(search_params)
    @wu = WeatherUnderground::Conditions.new
    @response = @wu.find_by_zipcode(search_params[:zipcode])
    query = MultiJson.decode(@response, :symbolize_keys => true)
    unless query[:current_observation].nil?
      search_params.city = query[:current_observation][:display_location][:city]
      search_params.state = query[:current_observation][:display_location][:state]
      search_params.temp_f = query[:current_observation][:temp_f]
    end
    search_params.response = @response
    return search_params
  end

  private
    def ensure_zipcode_is_real
      unless self.response.nil?
        query = MultiJson.decode(self.response, :symbolize_keys => true)
        unless query[:response][:error].nil?
          unless query[:response][:error][:description].nil?
            errors.add(:zipcode, ': zipcode not found.')
          end
        end
      end
    end

end

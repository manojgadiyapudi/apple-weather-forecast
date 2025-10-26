require 'net/http'
require 'json'
require 'singleton'

#
# This service fetches weather forecast data from OpenWeatherMap API
#
# It uses the OpenWeatherMap API to retrieve weather data based on ZIP code and country code.
class ForecastService
  include Singleton

  OPENWEATHER_API_KEY = ENV['OPENWEATHER_API_KEY']
  WEATHER_API_BASE_URL = ENV['WEATHER_API_BASE_URL']

  #
  # Fetches the weather forecast for a given ZIP code and optional country code.
  #
  # @param zip_code [String] The ZIP code for which to fetch the forecast.
  # @param country [String] The country code (e.g., "US", "IN").
  # @return [Hash] A hash containing temperature, high, low, and description.
  # @raise [StandardError] If there is an error fetching or parsing the data.
  #
  def get_forecast(zip_code, country)
    return missing_config_error unless configured?

    response = fetch_forecast_data(zip_code, country)
    parse_forecast_response(response, zip_code, country)
  rescue JSON::ParserError
    raise I18n.t('parsing_error')
  rescue SocketError, Timeout::Error => e
    raise "Network error: #{e.message}"
  rescue StandardError => e
    raise "Unexpected error: #{e.message}"
  end

  private

  #
  # Checks if the necessary configuration is present.
  #
  # @return [Boolean] True if configured, false otherwise.
  #
  def configured?
    WEATHER_API_BASE_URL.present? && OPENWEATHER_API_KEY.present?
  end

  #
  # Returns an error hash for missing configuration.
  #
  # @return [Hash] Error message hash.
  #
  def missing_config_error
    return { error: I18n.t('forecast_service.config.base_url_missing') } if WEATHER_API_BASE_URL.blank?

    { error: I18n.t('forecast_service.config.api_key_missing') } if OPENWEATHER_API_KEY.blank?
  end

  #
  # Fetches weather data from the OpenWeatherMap API.
  #
  # @param zip_code [String] The ZIP code.
  # @param country [String] The country code.
  # @return [Net::HTTPResponse] The HTTP response from the API.
  #
  def fetch_forecast_data(zip_code, country)
    uri = URI(WEATHER_API_BASE_URL)
    params = { zip: "#{zip_code},#{country}", appid: OPENWEATHER_API_KEY, units: 'metric' }
    uri.query = URI.encode_www_form(params)
    Net::HTTP.get_response(uri)
  end

  #
  # Parses the forecast response from the API.
  # @param response [Net::HTTPResponse] The HTTP response from the API.
  # @param zip_code [String] The ZIP code.
  # @param country [String] The country code.
  # @return [Hash] Parsed forecast data or error message.
  #
  def parse_forecast_response(response, zip_code, country)
    data = JSON.parse(response.body)
    return { error: data['message'] } unless response.is_a?(Net::HTTPSuccess)

    if data['main'].nil? || data['weather'].nil?
      return { error: I18n.t('forecast_service.messages.no_data_found', zip_code: zip_code) }
    end

    forecast_success_response(data, zip_code, country)
  end

  #
  # Formats a successful forecast response.
  # @param data [Hash] The parsed JSON data from the API.
  # @param zip_code [String] The ZIP code.
  # @param country [String] The country code.
  # @return [Hash] A hash containing formatted forecast data.
  #
  def forecast_success_response(data, zip_code, country)
    {
      temp: data['main']['temp'],
      high: data['main']['temp_max'],
      low: data['main']['temp_min'],
      humidity: data['main']['humidity'],
      sea_level: data['main']['sea_level'],
      description: data['weather'].first['description'],
      zip_code: zip_code,
      country: country
    }
  end
end

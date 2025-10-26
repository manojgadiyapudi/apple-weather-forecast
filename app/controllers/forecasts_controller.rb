# frozen_string_literal: true

# This controller handles the display of weather forecasts
class ForecastsController < ApplicationController
  #
  # Handles the creation of a new forecast request.
  #
  def create
    validation_result = validate_forecast_params
    return redirect_with_validation_error(validation_result[:error]) unless validation_result[:valid]

    @forecast = fetch_forecast(validation_result[:zip_code], validation_result[:country])
    handle_forecast_response
  end

  private

  #
  # Validates the forecast request parameters.
  #
  # @return [Hash] Validation result containing :valid flag and error message if invalid.
  #
  def validate_forecast_params
    zip_code = forecast_params[:zip_code]&.strip
    country = forecast_params[:country]&.strip&.upcase

    return { valid: false, error: 'forecast_controller.alerts.enter_zip' } if zip_code.blank?
    return { valid: false, error: 'forecast_controller.alerts.enter_country' } if country.blank?

    { valid: true, zip_code: zip_code, country: country }
  end

  #
  # Redirects with a validation error message.
  #
  def redirect_with_validation_error(error_key)
    flash[:alert] = I18n.t(error_key)
    redirect_to root_path
  end

  #
  # Fetches the forecast data, utilizing caching.
  #
  # @param zip_code [String] The ZIP code for the forecast.
  # @param country [String] The country code for the forecast.
  # @return [Hash] The forecast data or error message.
  #
  def fetch_forecast(zip_code, country)
    cache_expiry = (ENV['FORECAST_CACHE_EXPIRY'] || '30').to_i.minutes
    Rails.cache.fetch("forecast_#{zip_code}_#{country}", expires_in: cache_expiry) do
      ForecastService.instance.get_forecast(zip_code, country)
    end
  rescue StandardError => e
    flash[:alert] = I18n.t('forecast_controller.messages.error', error: e.message)
    redirect_to root_path
  end

  #
  # Handles the forecast response, redirecting on error or rendering on success.
  #
  def handle_forecast_response
    return redirect_with_forecast_error if @forecast.is_a?(Hash) && @forecast[:error]

    flash[:notice] = I18n.t('forecast_controller.messages.success')
    render :show
  end

  #
  # Redirects with a forecast error message.
  #
  def redirect_with_forecast_error
    error_message = @forecast[:error] || 'Unknown error'
    flash[:alert] = I18n.t('forecast_controller.messages.error', error: error_message)
    redirect_to root_path
  end

  def forecast_params
    params.permit(:zip_code, :country)
  end
end

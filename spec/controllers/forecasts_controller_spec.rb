# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ForecastsController, type: :controller do
  describe 'POST #create' do
    let(:zip_code) { '12345' }
    let(:country) { 'US' }
    let(:forecast_data) { { temperature: '25°C', condition: 'Sunny' } }

    context 'with valid parameters' do
      before do
        Rails.cache.clear
        allow(ForecastService.instance).to receive(:get_forecast)
          .with(zip_code, country)
          .and_return(forecast_data)
      end

      it 'successfully creates forecast and renders show' do
        post :create, params: { zip_code: zip_code, country: country }

        expect(assigns(:forecast)).to eq(forecast_data)
        expect(response).to render_template(:show)
        expect(flash[:notice]).to eq(I18n.t('forecast_controller.messages.success'))
      end
    end

    context 'with invalid parameters' do
      it 'redirects when zip_code is missing' do
        post :create, params: { zip_code: '', country: country }

        expect(response).to redirect_to(root_path)
        expect(flash[:alert]).to eq(I18n.t('forecast_controller.alerts.enter_zip'))
      end

      it 'redirects when country is missing' do
        post :create, params: { zip_code: zip_code, country: '' }

        expect(response).to redirect_to(root_path)
        expect(flash[:alert]).to eq(I18n.t('forecast_controller.alerts.enter_country'))
      end
    end

    context 'when service returns error' do
      before do
        Rails.cache.clear
        allow(ForecastService.instance).to receive(:get_forecast)
          .with(zip_code, country)
          .and_return({ error: 'Invalid location' })
      end

      it 'redirects with error message' do
        post :create, params: { zip_code: zip_code, country: country }

        expect(response).to redirect_to(root_path)
        expect(flash[:alert]).to eq(I18n.t('forecast_controller.messages.error', error: 'Invalid location'))
      end
    end
  end
end

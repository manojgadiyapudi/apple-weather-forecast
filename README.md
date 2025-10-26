# 🌤️ Apple Weather Forecast

A simple, clean weather forecast application built with Ruby on Rails that provides real-time weather information using the OpenWeatherMap API.

## 📖 Overview

Apple Weather Forecast is a web application that allows users to get current weather information by entering a ZIP code and country code. The application features a clean, minimalist design and provides comprehensive weather data including temperature, humidity, and weather descriptions.

## ✨ Features

- **Simple Interface**: Clean and intuitive form for entering location details
- **Real-time Weather Data**: Fetches current weather information from OpenWeatherMap API
- **Comprehensive Weather Info**: Displays temperature, high/low, humidity, sea level pressure, and weather description
- **Input Validation**: Client-side and server-side validation for ZIP code and country code
- **Caching**: Implements Redis caching to improve performance and reduce API calls
- **Error Handling**: Graceful error handling with user-friendly messages
- **Responsive Design**: Works on both desktop and mobile devices
- **Internationalization**: Support for multiple languages using Rails i18n

## 🛠️ Tech Stack

- **Framework**: Ruby on Rails 5.0.1
- **Ruby Version**: 2.7.8
- **Database**: SQLite3 (development), PostgreSQL (production ready)
- **Caching**: Redis
- **Template Engine**: Slim
- **Testing**: RSpec with FactoryBot
- **API**: OpenWeatherMap API
- **Environment Variables**: Figaro gem for configuration management

## 📋 Prerequisites

Before running this application, ensure you have the following installed:

- Ruby 2.7.8
- Rails 5.0.1+
- SQLite3
- Redis server
- Bundler gem

## ⚙️ Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/manojgadiyapudi/apple-weather-forecast.git
   cd apple-weather-forecast
   ```

2. **Install dependencies:**
   ```bash
   bundle install
   ```

3. **Set up the database:**
   ```bash
   rails db:create
   rails db:migrate
   rails db:seed
   ```

4. **Configure environment variables:**
   Create a `config/application.yml` file and add your OpenWeatherMap API credentials:
   ```yaml
   OPENWEATHER_API_KEY: "your_openweather_api_key_here"
   WEATHER_API_BASE_URL: "https://api.openweathermap.org/data/2.5/weather"
   FORECAST_CACHE_EXPIRY: "30" # Cache expiry in minutes
   ```

5. **Start Redis server:**
   ```bash
   redis-server
   ```

6. **Start the Rails server:**
   ```bash
   rails server
   ```

7. **Visit the application:**
   Open your browser and navigate to `http://localhost:3000`

## 🔧 Configuration

### OpenWeatherMap API Setup

1. Sign up for a free account at [OpenWeatherMap](https://openweathermap.org/api)
2. Generate an API key from your account dashboard
3. Add the API key to your `config/application.yml` file

### Cache Configuration

The application uses Redis for caching forecast data. You can configure the cache expiry time by setting the `FORECAST_CACHE_EXPIRY` environment variable (in minutes).

## 🧪 Testing

The application includes comprehensive test coverage using RSpec:

```bash
# Run all tests
bundle exec rspec

# Run specific test files
bundle exec rspec spec/controllers/forecasts_controller_spec.rb
bundle exec rspec spec/services/forecast_service_spec.rb

# Run tests with coverage
bundle exec rspec --format documentation
```

### Test Coverage

- **Controller Tests**: Complete coverage of ForecastsController actions
- **Service Tests**: Comprehensive testing of ForecastService API interactions
- **Integration Tests**: End-to-end testing of user workflows
- **Mocking**: Uses WebMock for external API testing

## 📁 Project Structure

```
apple-weather-forecast/
├── app/
│   ├── controllers/
│   │   ├── application_controller.rb
│   │   └── forecasts_controller.rb
│   ├── services/
│   │   └── forecast_service.rb
│   ├── views/
│   │   ├── layouts/
│   │   │   └── application.html.slim
│   │   └── forecasts/
│   │       ├── new.html.slim
│   │       └── show.html.slim
│   └── assets/
├── config/
│   ├── routes.rb
│   ├── application.yml (you need to create this)
│   └── locales/
│       └── en.yml
├── spec/
│   ├── controllers/
│   ├── services/
│   └── spec_helper.rb
└── README.md
```

## 🚀 API Endpoints

| Method | Path | Description |
|--------|------|-------------|
| GET | `/` | Home page with weather form |
| POST | `/forecast` | Submit weather request and display results |

## 🔍 Usage

1. **Enter Location Details:**
   - ZIP Code: Enter a valid ZIP code (4-10 characters)
   - Country Code: Enter a 2-letter country code (e.g., US, IN, UK)

2. **Submit Form:**
   - Click "Get Forecast" to fetch weather data

3. **View Results:**
   - Current temperature in Celsius
   - Weather description
   - High and low temperatures
   - Humidity percentage
   - Sea level pressure

## 🛡️ Error Handling

The application handles various error scenarios:

- **Invalid Input**: Client-side validation for ZIP code and country format
- **API Errors**: Graceful handling of OpenWeatherMap API errors
- **Network Issues**: Timeout and connection error handling
- **Missing Configuration**: Clear error messages for missing API keys
- **Invalid Location**: User-friendly messages for non-existent locations

## 🖼️ Screenshots

RSpec & UI Testing Reports

<img width="1512" height="875" alt="Screenshot 2025-10-26 at 3 07 27 PM" src="https://github.com/user-attachments/assets/0ef461ba-6a9f-4e9c-b1e0-61cc438312a5" />
<img width="1504" height="478" alt="Screenshot 2025-10-26 at 3 07 48 PM" src="https://github.com/user-attachments/assets/35878f32-4875-4292-98d8-d41a9be57cdc" />
<img width="1504" height="478" alt="Screenshot 2025-10-26 at 3 07 56 PM" src="https://github.com/user-attachments/assets/6b1022eb-7f28-4d83-98df-ff7357a639e2" />
<img width="1504" height="478" alt="Screenshot 2025-10-26 at 3 08 15 PM" src="https://github.com/user-attachments/assets/8ac874ab-8f19-4f62-9fe3-e880dd3b01c4" />
<img width="1504" height="478" alt="Screenshot 2025-10-26 at 3 08 06 PM" src="https://github.com/user-attachments/assets/3278cebd-9d74-4a1f-98fb-8f1be1bb2e11" />
<img width="1502" height="818" alt="Screenshot 2025-10-26 at 3 04 24 PM" src="https://github.com/user-attachments/assets/bc8fe47c-a26d-42f9-abd7-884fbd6f22e1" />








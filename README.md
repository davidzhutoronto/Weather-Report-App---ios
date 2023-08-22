![picture](https://github.com/davidzhutoronto/Weather-Report-App---ios/blob/main/WX20230822-175745%402x.png|width=200px)

![picture2](https://github.com/davidzhutoronto/Weather-Report-App---ios/blob/main/WX20230822-175801%402x.png|width=200px)


Weather Report App
==================

The Weather Report App is a two-screen iOS application that allows users to search for the current weather report of their current city and view a history of previously saved weather reports. The app is organized using a Navigation Controller to provide a seamless user experience.

Screens and Functionality
-------------------------

### Screen 1 - Current Weather Report

This screen displays the current weather information at the device's current location. The following details are displayed:

-   City Name: The name of the city where the device is currently located.
-   Current Temperature: The actual temperature in Celsius.
-   Wind Speed: The wind speed in kilometers per hour.
-   Wind Direction: The direction of the wind.

Users can tap the "SAVE REPORT" button to save the current weather report. This will allow them to view the saved reports on Screen 2.

### Screen 2 - Weather History

On this screen, users can view a list of previously saved weather reports. Each row in the table view displays the following information:

-   City: The city where the weather report was taken.
-   Time: The time the report was saved.
-   Temperature: The temperature in Celsius.
-   Wind Speed and Direction: The wind speed and direction.

Users can navigate back to the previous screen using the "< Back" button in the navigation bar.

Data Modeling
-------------

Weather-related data is represented using a custom Weather class. The Weather class includes properties such as city name, temperature, wind speed, wind direction, and time. Data is passed between screens without using persistence layers, ensuring that the app forgets any previous weather data when closed.

API Integration
---------------

The app uses the WeatherAPI.com API to fetch weather data. To set up the API integration, follow these steps:

1.  Sign up for a free account on WeatherAPI.com.
2.  Replace `YOUR_API_KEY` in the API endpoint with the API key associated with your WeatherAPI.com account.
3.  Replace `CITY` in the API endpoint with the city you are searching for weather in.

API Endpoint:

bashCopy code

```https://api.weatherapi.com/v1/current.json?key=YOUR_API_KEY&q=CITY&aqi=no```

Getting Started
---------------

To run the Weather Report App on your iPhone 11 simulator, follow these steps:

1.  Clone or download the project repository.
2.  Open the Xcode project in Xcode.
3.  Build and run the app on the iPhone 11 simulator.
4.  Ensure that location services are enabled in the simulator settings for accurate weather data.

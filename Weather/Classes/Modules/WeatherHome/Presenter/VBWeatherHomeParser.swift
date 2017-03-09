/**
 * @author Vignesh Babu
 *
 * @brief Weather data mapper from JSON to VBWeatherMap
 *
 * @version 1.0
 *
 * @copyright Copyright (c) 2017 Vignesh Babu. All rights reserved.
 */

import Foundation

/// Parse the Weather Response data in JSON format into VBWeatherMap instance
class VBWeatherHomeParser: NSObject {

    /**
     Parse the weather map data
     
     - Parameter dataDictionary: Weather JSON data as NSDictionary instance
     */
    func parserWeatherMapData(_ dataDictionary: NSDictionary) -> VBWeatherMap? {
        var windSpeed: Float?
        let windInfo = dataDictionary[WeatherMap.Json.WIND] as? NSDictionary
        if windInfo != nil {
            windSpeed = windInfo?[WeatherMap.Json.WIND_SPEED] as? Float
        }
        
        var weatherDescription: String? = nil
        var icon: String? = nil
        let weatherArray = dataDictionary[WeatherMap.Json.WEATHER] as? NSArray
        if (weatherArray != nil) {
            for weatherInfo in weatherArray! {
                if let weatherInfo = weatherInfo as? NSDictionary {
                    weatherDescription = weatherInfo[WeatherMap.Json.WEATHER_DESCRIPTION] as? String
                    icon = weatherInfo[WeatherMap.Json.WEATHER_ICON] as? String
                }
            }
        }
        
        var pressure: Float? = nil
        var temperature: Float? = nil
        var temperatureMin: Float? = nil
        var temperatureMax: Float? = nil
        var humidity: Float? = nil
        let main = dataDictionary[WeatherMap.Json.MAIN] as? NSDictionary
        if main != nil {
            pressure = main?[WeatherMap.Json.MAIN_PRESSURE] as? Float
            temperature = main?[WeatherMap.Json.MAIN_TEMP] as? Float
            temperatureMin = main?[WeatherMap.Json.MAIN_TEMP_MIN] as? Float
            temperatureMax = main?[WeatherMap.Json.MAIN_TEMP_MAX] as? Float
            humidity = main?[WeatherMap.Json.MAIN_HUMIDITY] as? Float
        }
    
        var latitude : Float? = nil
        var longitude : Float? = nil
        let coordinatesDictionary = dataDictionary[WeatherMap.Json.COORDINATES] as? NSDictionary
        if let coordinatesDictionary = coordinatesDictionary {
            latitude = coordinatesDictionary[WeatherMap.Json.COORDINATES_LATITUDE] as? Float
            longitude = coordinatesDictionary[WeatherMap.Json.COORDINATES_LONGITUDE] as? Float
        }
        
        var country: String? = nil
        var sunriseDate:Date? = nil
        var sunsetDate:Date? = nil
        let system = dataDictionary[WeatherMap.Json.SYS] as? NSDictionary
        if system != nil {
            country = system?[WeatherMap.Json.SYS_COUNTRY] as? String
            
            if let jsonSunriseTime = system?[WeatherMap.Json.SYS_SUNRISE] as? Double {
                sunriseDate = Date(timeIntervalSince1970: jsonSunriseTime)
            }
            
            if let jsonSunriseTime = system?[WeatherMap.Json.SYS_SUNSET] as? Double {
                sunsetDate = Date(timeIntervalSince1970: jsonSunriseTime)
            }
        }
        
        let city = dataDictionary[WeatherMap.Json.NAME] as? String
        let errorMessage = dataDictionary[WeatherMap.Json.MESSAGE] as? String
        let statusCode = dataDictionary[WeatherMap.Json.STATUS_CODE] as? Int
        let visibility = dataDictionary[WeatherMap.Json.VISIBILITY] as? Float
        
        return VBWeatherMap(windSpeed: windSpeed, weatherDescription: weatherDescription, pressure: pressure, icon: icon, humidity: humidity, sunrise: sunriseDate, sunset: sunsetDate, temperature: temperature, temperatureMin: temperatureMin, temperatureMax: temperatureMax, visibility: visibility, latitude: latitude, longitude: longitude, country: country, city: city, statusCode: statusCode, errorMessage: errorMessage)
    }
}

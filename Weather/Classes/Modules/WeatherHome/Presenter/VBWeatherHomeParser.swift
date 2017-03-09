/**
 * @author Vignesh Babu
 *
 * @brief
 *
 * @version 1.0
 *
 * @copyright Copyright (c) 2017 Vignesh Babu. All rights reserved.
 */

import Foundation

///
class VBWeatherHomeParser: NSObject {

    func parserWeatherMapData(_ dataDictionary: NSDictionary) -> VBWeatherMap? {

        var windSpeed: Float?
        let windInfo = dataDictionary[WeatherMap.Json.WIND_SPEED] as? NSDictionary
        if windInfo != nil {
            windSpeed = windInfo?[WeatherMap.Json.WIND_SPEED] as? Float
        }
        
        
        var weatherDescription: String? = nil
        var icon: String? = nil
        
        let weatherArray = dataDictionary[WeatherMap.Json.WEATHER] as? NSArray
        if (weatherArray != nil) {
            for weather in weatherArray! {
                if weather is NSDictionary {
                    weatherDescription = dataDictionary[WeatherMap.Json.WEATHER_DESCRIPTION] as? String
                    icon = dataDictionary[WeatherMap.Json.WEATHER_ICON] as? String
                }
            }
        }
        
        var sunriseDate:Date? = nil
        if let jsonSunriseTime = dataDictionary[WeatherMap.Json.WIND_SPEED] as? Double {
            sunriseDate = Date(timeIntervalSince1970: jsonSunriseTime)
        }
        
        var sunsetDate:Date? = nil
        if let jsonSunriseTime = dataDictionary[WeatherMap.Json.WIND_SPEED] as? Double {
            sunsetDate = Date(timeIntervalSince1970: jsonSunriseTime)
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
            humidity = main?[WeatherMap.Json.WIND_SPEED] as? Float
        }
        
        let visibility = dataDictionary[WeatherMap.Json.VISIBILITY] as? Float
        
        var latitude : Float? = nil
        var longitude : Float? = nil
        let coordinatesDictionary = dataDictionary[WeatherMap.Json.COORDINATES] as? NSDictionary
        if let coordinatesDictionary = coordinatesDictionary {
            latitude = coordinatesDictionary[WeatherMap.Json.COORDINATES_LATITUDE] as? Float
            longitude = coordinatesDictionary[WeatherMap.Json.COORDINATES_LONGITUDE] as? Float
        }
        
        var country: String? = nil
        let system = dataDictionary[WeatherMap.Json.SYS] as? NSDictionary
        if system != nil {
            country = system?[WeatherMap.Json.SYS_COUNTRY] as? String
        }
        
        let city = dataDictionary[WeatherMap.Json.NAME] as? String
        let errorMessage = dataDictionary[WeatherMap.Json.MESSAGE] as? String
        let statusCode = dataDictionary[WeatherMap.Json.STATUS_CODE] as? Int
        
        return VBWeatherMap(windSpeed: windSpeed, weatherDescription: weatherDescription, pressure: pressure, icon: icon, humidity: humidity, sunrise: sunriseDate, sunset: sunsetDate, temperature: temperature, temperatureMin: temperatureMin, temperatureMax: temperatureMax, visibility: visibility, latitude: latitude, longitude: longitude, country: country, city: city, statusCode: statusCode, errorMessage: errorMessage)
    }
}



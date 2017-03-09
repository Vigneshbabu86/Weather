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
import UIKit

/// Weather data for a specific location
class VBWeatherMap: NSObject {
    
    /// The wind speed at the given time in miles per hour.
	public var windSpeed: Float?
    
    /// A text summary of the weather.
	public var weatherDescription: String?
    
    /// The sea-level air pressure in millibars.
	public var pressure: Float?
    
    /// Name of the icon suitable for the weather to display
    public var icon: String?
    
    /// Value between `0` and `1` (inclusive) representing the relative humidity.
    public var humidity: Float?
    
    /// The time of the last sunrise before the solar noon closest to local noon on the given day.
	public var sunrise: Date?
    
    /// The time of the first sunset after the solar noon closest to local noon on the given day.
	public var sunset: Date?
    
    /// The temperature at the given time in degrees Fahrenheit.
    public var temperature: Float?
    
    /// The minimum temperature on the given day in degrees Fahrenheit.
    public var temperatureMin: Float?
    
    /// The maximum temperature on the given day in degrees Fahrenheit.
    public var temperatureMax: Float?
    
    /// The average visibility in miles, capped at `10`.
    public var visibility: Float?
    
    /// Latitude of the location
	public var latitude: Float?
    
    /// Longitude of the location
    public var longitude: Float?
    
    /// Name of the country
    public var country: String?
    
    // Name of the city
    public var city: String?
	
    /// Name of the country
    public var statusCode: Int?
    
    /// Name of the city
    public var errorMessage: String?
    
    /// Self description of the instance
    override var description: String {
        let selfDescription = "Wind Speed : \(self.windSpeed) \n" +
        "Weather Description \(weatherDescription) \n"
        return selfDescription
    }

    init?( windSpeed: Float?, weatherDescription: String?, pressure: Float?, icon: String?, humidity: Float?, sunrise: Date?, sunset: Date?, temperature: Float?, temperatureMin: Float?, temperatureMax: Float?, visibility: Float?, latitude: Float?, longitude: Float?, country: String?, city: String?, statusCode:Int?, errorMessage:String?) {

        self.windSpeed = windSpeed
        self.weatherDescription = weatherDescription
        self.pressure = pressure
        self.icon = icon
        self.humidity = humidity
        self.sunrise = sunrise
        self.sunset = sunset
        self.temperature = temperature
        self.temperatureMin = temperatureMin
        self.temperatureMax = temperatureMax
        self.visibility = visibility
        self.latitude = latitude
        self.longitude = longitude
        self.country = country
        self.city = city
        self.statusCode = statusCode
        self.errorMessage = errorMessage
	}
    
}

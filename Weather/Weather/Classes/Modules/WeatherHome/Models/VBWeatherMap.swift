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

class VBWeatherMap: NSObject {
	var wind: String?
	var cloudiness: String?
	var pressure: String?
	var humidity: String?
	var sunrise: String?
	var sunset: String?
	var geoCoordinates: String?
	

    init?( wind: String, cloudiness: String, pressure: String, humidity: String, sunrise: String, sunset: String, geoCoordinates: String) {

        self.wind = wind
        self.cloudiness = cloudiness
        self.pressure = pressure
        self.humidity = humidity
        self.sunrise = sunrise
        self.sunset = sunset
        self.geoCoordinates = geoCoordinates

	}
}

/**
 * @author Vignesh Babu
 *
 * @brief List of Constants used by the module Weather Launch Screen
 *
 * @version 1.0
 *
 * @copyright Copyright (c) 2017 Vignesh Babu. All rights reserved.
 */

import Foundation

/// Holds the weather map response entries
struct WeatherMap {
	struct Json {
		static let COORDINATES = "coord"
		static let COORDINATES_LONGITUDE = "lon"
		static let COORDINATES_LATITUDE = "lat"
		static let WEATHER = "weather"
		static let WEATHER_ID = "id"
		static let WEATHER_MAIN = "main"
		static let WEATHER_DESCRIPTION = "description"
		static let WEATHER_ICON = "icon"
		static let MAIN = "main"
		static let MAIN_TEMP = "temp"
		static let MAIN_PRESSURE = "pressure"
		static let MAIN_HUMIDITY = "humidity"
		static let MAIN_TEMP_MIN = "temp_min"
		static let MAIN_TEMP_MAX = "temp_max"
		static let VISIBILITY = "visibility"
        static let WIND = "wind"
        static let WIND_SPEED = "speed"
        static let WIND_DEG = "deg"
        static let CLOUDS = "clouds"
        static let SYS = "sys"
        static let SYS_TYPE = "type"
        static let SYS_ID = "roles"
        static let SYS_MESSAGE = "message"
        static let SYS_COUNTRY = "country"
        static let SYS_SUNRISE = "sunrise"
        static let SYS_SUNSET = "sunset"
        static let ID = "id"
        static let NAME = "name"
        static let STATUS_CODE = "cod"
        static let MESSAGE = "message"
	}
}

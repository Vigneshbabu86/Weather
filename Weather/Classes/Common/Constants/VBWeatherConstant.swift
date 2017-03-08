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

struct VBWeatherConstant {
    struct openWeatherMap {
        struct openWeatherMapKeys {
            static let openWeatherMapApiKey = "57458ef17470dcbfbcbd98dfc247ec2b"
        }
        struct openWeatherMapParmeterKeys {
            static let openWeatherMapAppIdParameterKey = "appid"
            static let openWeatherMapQueryByCityNameParameterKey = "q"
        }
        struct openWeatherMapURL {
            static let openWeatherMapURL = "api.openweathermap.org/data/2.5/weather"
        }
    }
}

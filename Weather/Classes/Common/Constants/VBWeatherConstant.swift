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
        struct openWeatherMapURLs {
            static let openWeatherMapURL = "http://api.openweathermap.org/data/2.5/weather"
            static let openWeatherMapImageURL = "http://openweathermap.org/img/w/"
        }
    }
    
    struct WebServiceRequestTypes {
        static let GET = "GET"
        static let DELETE = "DELETE"
        static let POST = "POST"
        static let PUT = "PUT"
        static let HEAD = "HEAD"
    }
    
    struct Network {
        static let Network_Failed = "Network Error"
        static let Network_Failed_Message = "No internet connection available."
        static let NETWORK_FAIL_MESSSAGE_FOR_SEARCH =
        "Network error.\nPlease check your internet connection and try again."
        static let NETWORK_FAIL_ERROR_MESSSAGE_BODY = "Check your internet connection and try again."

    }
}

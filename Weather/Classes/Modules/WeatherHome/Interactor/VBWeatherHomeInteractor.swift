/**
 * @author Vignesh Babu
 *
 * @brief Contains the business logic as specified by a use case.
 *
 * @version 1.0
 *
 * @copyright Copyright (c) 2017 Vignesh Babu. All rights reserved.
 */
import Foundation


//MARK: Output Interface
protocol VBWeatherHomeInteractorOutput {
    func weatherDataRequestComplete(_ weatherMapEntity: VBWeatherMap?, error: NSError?)
    func weatherDataRequestFailed(_ title: String?, errorMsg: String!)
    func isValidCityTextEntry (_ isValid: Bool, errorMsg: String!, cityName:String!)
}

/// Holds the bussiness logic and helps the Interactor to prepare the data display
class VBWeatherHomeInteractor : VBWeatherHomeViewControllerOutput, VBWeatherHomeWorkerOutput {
    var output: VBWeatherHomeInteractorOutput!
    let weatherParser = VBWeatherHomeParser()
    fileprivate var weatherWorker = VBWeatherHomeWorker()
    
    // MARK:  VBWeatherHomeViewControllerOutput
    
    /**
     Validate the city text entry
     
     - Parameter city: Name of the city used to get the weather
     */
    internal func validateCity(_ city: String) {
        let alphaNumericMatch = city.range(of: "^(?=.*\\d)(?=.*[a-zA-Z]+)[-\\w!@.-_]+$", options: .regularExpression)
        if city.isEmpty {
            output.isValidCityTextEntry(false, errorMsg: "Please enter the city name to continue", cityName: city)
        } else if (city.characters.count < 2 || (alphaNumericMatch != nil) ) {
            output.isValidCityTextEntry(false, errorMsg: "Please enter the valid city name to continue", cityName: city)
        } else {
            output.isValidCityTextEntry(true, errorMsg: "", cityName: city)
        }
    }
    
    /**
     Lookup the weather for the given city
     
     - Parameter city: Name of the city used to get the weather
     */
    internal func searchWeatherForCity(_ city: String) {
        weatherWorker.delegate = self
        weatherWorker.lookupWeather(city)
    }
    
    /**
     Save the last city in local cache for application n=next relaunch
     
     - Parameter city: Name of the city used to get the weather
     */
    internal func saveLastSearchedCity(_ city: String) {
        
    }

    // MARK:  VBWeatherHomeWorkerOutput
    /**
     Helps to request the parser to convert the JSON result into WeatherMap instance
     
     - Parameter jsonresult: Weather JSON data for city as NSDictionary
     */
    internal func weatherResults(_ jsonresult: NSDictionary) {
        let weatherMap = weatherParser.parserWeatherMapData(jsonresult)
        self.output.weatherDataRequestComplete(weatherMap, error: nil)
    }
    
    internal func weatherError(_ title: String?, message: String!) {
        self.output.weatherDataRequestFailed(title, errorMsg: message)
    }
}



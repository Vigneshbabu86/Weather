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


//MARK: Output Interface
protocol VBWeatherHomeInteractorOutput {
    func weatherDataRequestComplete(_ dataDictionary: NSDictionary, error: NSError?)
    func weatherDataRequestFailed(_ title: String?, errorMsg: String!)
    func inValidCityTextEntry (_ isValid: Bool, errorMsg: String!, cityName:String!)
}

///
class VBWeatherHomeInteractor : VBWeatherHomeViewControllerOutput, VBWeatherHomeWorkerOutput {
    var output: VBWeatherHomeInteractorOutput!
    fileprivate var loginWorker = VBWeatherHomeWorker()
    
    // MARK:  VBWeatherHomeViewControllerOutput
    
    internal func validateCity(_ city: String) {
        let alphaNumericMatch = city.range(of: "^(?=.*\\d)(?=.*[a-zA-Z]+)[-\\w!@.-_]+$", options: .regularExpression)
        if city.isEmpty {
            output.inValidCityTextEntry(false, errorMsg: "Please enter the city name to continue", cityName: city)
        } else if (city.characters.count < 2 || (alphaNumericMatch != nil) ) {
            output.inValidCityTextEntry(false, errorMsg: "Please enter the valid city name to continue", cityName: city)
        } else {
            output.inValidCityTextEntry(true, errorMsg: "", cityName: city)
        }
    }
    
    internal func searchWeatherForCity(_ city: String) {
        
    }
    
    internal func saveLastSearchedCity(_ city: String) {
        
    }

    // MARK:  VBWeatherHomeWorkerOutput
    
    internal func weatherResults(_ jsonresult: NSDictionary) {
        self.output.weatherDataRequestComplete(jsonresult, error: nil)
    }
    
    internal func weatherError(_ title: String?, message: String!) {
        self.output.weatherDataRequestFailed(title, errorMsg: message)
    }
}



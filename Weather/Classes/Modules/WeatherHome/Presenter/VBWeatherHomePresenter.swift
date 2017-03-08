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
protocol VBWeatherHomePresenterOutput: class {
    func updateViewBasedOnWeatherRequestSuccess(_ weatherMap: VBWeatherMap)
    func updateViewBasedOnCityTextEntry(_ isSuccess: Bool, errorMsg: String?, cityName: String!)
    func updateViewBasedOnWeatherRequestFailed(_ title: String?, errorMsg: String!)
    func hideActivityIndicator()
}

class VBWeatherHomePresenter: NSObject, VBWeatherHomeInteractorOutput {
    weak var output: VBWeatherHomePresenterOutput!
    fileprivate var weatherParser = VBWeatherHomeParser()
    
    // MARK: VBWeatherHomeInteractorOutput
    /**
     Handles the success of the weather request completion
     
     - Parameter dataDictionary:   JSON representation of object.
     - Parameter error: The error instance if any
     */
    internal func weatherDataRequestComplete(_ dataDictionary: NSDictionary, error: NSError?) {
        
    }
    
    /**
     Handles the failure status of the weather request completion
     
     - Parameter title: The alert title needs to be used
     - Parameter error: The error message needs to be displayed
     */
    internal func weatherDataRequestFailed(_ title: String?, errorMsg: String!) {
        
    }
    
    /**
     Handles the failure status of the weather request completion
     
     - Parameter title: The alert title needs to be used
     - Parameter error: The error message needs to be displayed
     */
    internal func inValidCityTextEntry (_ isValid: Bool, errorMsg: String!, cityName:String!) {
        if !isValid {
            output.hideActivityIndicator()
        }
        output.updateViewBasedOnCityTextEntry(isValid, errorMsg: errorMsg, cityName: cityName)
    }
}

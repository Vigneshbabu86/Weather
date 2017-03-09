/**
 * @author Vignesh Babu
 *
 * @brief Contains view logic for preparing content for display (as received from the Interactor) and for reacting to user inputs (by requesting new data from the Interactor)
 *
 * @version 1.0
 *
 * @copyright Copyright (c) 2017 Vignesh Babu. All rights reserved.
 */

import Foundation

//MARK: Output Interface
protocol VBWeatherHomePresenterOutput: class {
    func updateViewBasedOnWeatherRequestSuccess(_ weatherMap: VBWeatherMap?)
    func updateViewBasedOnCityTextEntry(_ isSuccess: Bool, errorMsg: String?, cityName: String!)
    func updateViewBasedOnWeatherRequestFailed(_ title: String?, errorMsg: String!)
    func hideActivityIndicator()
}

/// Prepares the data for display and Reacts to User Inputs
class VBWeatherHomePresenter: NSObject, VBWeatherHomeInteractorOutput {
    weak var output: VBWeatherHomePresenterOutput!
    fileprivate var weatherParser = VBWeatherHomeParser()
    
    // MARK: VBWeatherHomeInteractorOutput
    /**
     Handles the success of the weather request completion
     
     - Parameter dataDictionary:   JSON representation of object.
     - Parameter error: The error instance if any
     */
    internal func weatherDataRequestComplete(_ weatherMapEntity: VBWeatherMap?, error: NSError?) {
        if weatherMapEntity?.statusCode == 200 {
            output.updateViewBasedOnWeatherRequestSuccess(weatherMapEntity)
        }
        else {
         let errorMsg = weatherMapEntity?.errorMessage ?? ""
          output.updateViewBasedOnWeatherRequestFailed("", errorMsg: errorMsg)
        }
    }
    
    /**
     Handles the failure status of the weather request completion
     
     - Parameter title: The alert title needs to be used
     - Parameter error: The error message needs to be displayed
     */
    internal func weatherDataRequestFailed(_ title: String?, errorMsg: String!) {
        output.updateViewBasedOnWeatherRequestFailed(title, errorMsg: errorMsg)
    }
    
    /**
     Handles the failure status of the weather request completion
     
     - Parameter title: The alert title needs to be used
     - Parameter error: The error message needs to be displayed
     */
    internal func isValidCityTextEntry (_ isValid: Bool, errorMsg: String!, cityName:String!) {
        if !isValid {
            output.hideActivityIndicator()
        }
        output.updateViewBasedOnCityTextEntry(isValid, errorMsg: errorMsg, cityName: cityName)
    }
}

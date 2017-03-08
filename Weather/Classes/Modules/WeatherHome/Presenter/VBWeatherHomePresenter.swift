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
    func updateViewBasedOnLoginSuccess(_ weatherMap: VBWeatherMap)
    func updateViewBasedOnLoginFailed(_ title: String?, errorMsg: String!)
    func hideActivityIndicator()
}

class VBWeatherHomePresenter: NSObject, VBWeatherHomeInteractorOutput {
    
    weak var output: VBWeatherHomePresenterOutput!
    fileprivate var weatherParser = VBWeatherHomeParser()
    
    // MARK: VBWeatherHomeInteractorOutput
    internal func weatherDataRequestComplete(_ dataDictionary: NSDictionary, error: NSError?) {
        
    }
    
    internal func weatherDataRequestFailed(_ title: String?, errorMsg: String!) {
        
    }
}

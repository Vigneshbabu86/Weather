/**
 * @author Vignesh Babu
 *
 * @brief
 *
 * @version 1.0
 *
 * @copyright Copyright (c) 2017 Vignesh Babu. All rights reserved.
 */

import UIKit
import Foundation

protocol VBWeatherHomeWorkerOutput: class {
    func weatherResults(_ jsonresult: NSDictionary)
    func weatherError(_ title: String?, message: String!)
    
}

/// Worker Class to Handle the weather lookup for the city
class VBWeatherHomeWorker: NSObject {
    
    /// Worker Output Deleagte
    weak var delegate: VBWeatherHomeWorkerOutput?
    
    /**
     Helps to lookup the weather for the city
     
     - Parameter city: Name of the city used to get the weather
     */
    func lookupWeather(_ cityName: String){
        if VBWeatherUtilities.isConnectedToNetwork() {
            let baseURl =  VBWeatherConstant.openWeatherMap.openWeatherMapURLs.openWeatherMapURL
            let endPointURL = baseURl + "?" + VBWeatherConstant.openWeatherMap.openWeatherMapParmeterKeys.openWeatherMapQueryByCityNameParameterKey + "=" + cityName + "&" + VBWeatherConstant.openWeatherMap.openWeatherMapParmeterKeys.openWeatherMapAppIdParameterKey + "=" + VBWeatherConstant.openWeatherMap.openWeatherMapKeys.openWeatherMapApiKey
            VBWeatherWebServiceManager.GETRequest(endPointURL, completionHandler: { (responseObject, error) in
                
                DispatchQueue.main.async { [weak self] in
                    if let jsonResponse = responseObject as? NSDictionary {
                        self?.delegate?.weatherResults(jsonResponse)
                    }
                    else {
                        self?.delegate?.weatherError(VBWeatherConstant.Network.NetworkFailed, message: VBWeatherConstant.Network.NetworkFailedMessage)
                    }
                }
                
            })
        }
        else {
            self.delegate?.weatherError(VBWeatherConstant.Network.NetworkFailed, message: VBWeatherConstant.Network.NetworkFailedMessage)
        }
    }
}



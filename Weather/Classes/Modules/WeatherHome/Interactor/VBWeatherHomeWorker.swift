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

///
class VBWeatherHomeWorker: NSObject {
    
    weak var delegate: VBWeatherHomeWorkerOutput?
    
    func handleWeatherRequest(_ cityName: String){
        if VBWeatherUtilities.isConnectedToNetwork() {
            let baseURl =  VBWeatherConstant.openWeatherMap.openWeatherMapURLs.openWeatherMapURL
            let endPointURL = baseURl + "?" + VBWeatherConstant.openWeatherMap.openWeatherMapParmeterKeys.openWeatherMapQueryByCityNameParameterKey + "=" + cityName + "&" + VBWeatherConstant.openWeatherMap.openWeatherMapParmeterKeys.openWeatherMapAppIdParameterKey + "=" + VBWeatherConstant.openWeatherMap.openWeatherMapKeys.openWeatherMapApiKey
            VBWeatherWebServiceManager.GETRequest(endPointURL, completionHandler: { (responseObject, error) in
                if let jsonResponse = responseObject as? NSDictionary {
                    self.delegate?.weatherResults(jsonResponse)
                }
                else {
                    self.delegate?.weatherError(VBWeatherConstant.Network.Network_Failed, message: VBWeatherConstant.Network.Network_Failed_Message)
                }
            })
        }
        else {
            self.delegate?.weatherError(VBWeatherConstant.Network.Network_Failed, message: VBWeatherConstant.Network.Network_Failed_Message)
        }
    }
}



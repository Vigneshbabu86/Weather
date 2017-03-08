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
}

///
class VBWeatherHomeInteractor : VBWeatherHomeViewControllerOutput, VBWeatherHomeWorkerOutput {
    var output: VBWeatherHomeInteractorOutput!
    fileprivate var loginWorker = VBWeatherHomeWorker()
    
    // MARK:  VBWeatherHomeViewControllerOutput
    
    internal func validateCity(_ city: String) {
        
    }
    
    internal func searchWeatherForCity(_ city: String) {
        
    }
    
    internal func saveLastSearchedCity(_ city: String) {
        
    }

    // MARK:  VBWeatherHomeWorkerOutput
    
    internal func weatherResults(_ jsonresult: NSDictionary) {
        
    }
    
    internal func weatherError(_ title: String?, message: String!) {
        
    }
}



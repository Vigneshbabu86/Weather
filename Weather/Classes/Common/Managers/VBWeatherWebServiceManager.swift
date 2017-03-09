/**
 * @author Vignesh Babu
 *
 * @brief Web Service Manager to manage the service requests
 *
 * @version 1.0
 *
 * @copyright Copyright (c) 2017 Vignesh Babu. All rights reserved.
 */

import Foundation

final class VBWeatherWebServiceManager: NSObject {
    
    class var sharedInstance: VBWeatherWebServiceManager {
        struct Static {
            static let instance = VBWeatherWebServiceManager ()
        }
        return Static.instance
    }

    // MARK:GET Request
    static func GETRequest(_ urlString: String, completionHandler: @escaping (AnyObject?, Error?) -> ()) {
        
        let urlRequest = NSMutableURLRequest(url: URL(string: urlString)!)
        urlRequest.httpMethod = VBWeatherConstant.WebServiceRequestTypes.GET
        let task = URLSession.shared.dataTask(with: urlRequest as URLRequest, completionHandler: { data,response,error in
            if error != nil{
                completionHandler(nil, error)
            }
            
            if let data = data {
                if let responseJSON = (try? JSONSerialization.jsonObject(with: data, options: [])) as? [String:AnyObject]{
                    completionHandler(responseJSON as AnyObject?, nil)
                    return
                }
            }
            
            else {
                completionHandler(nil, nil)
            }
        })
        task.resume()
    }
}

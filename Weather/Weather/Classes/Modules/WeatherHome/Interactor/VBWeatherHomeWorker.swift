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
    
}



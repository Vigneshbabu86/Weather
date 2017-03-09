/**
 * @author Vignesh Babu
 *
 * @brief Utilities Methods
 *
 * @version 1.0
 *
 * @copyright Copyright (c) 2017 Vignesh Babu. All rights reserved.
 */

import Foundation

class VBWeatherUtilities: NSObject {

    // MARK: Null Data Management
    /**
     Check the object is null or not for the Key and Returns the key if exist otherwise the empty string as AnyObject
     
     - Parameter aKey: Unique to locate the object 
     - Parameter dictionary: Dictionary instance
     */
    class func objectOrNilForKey(_ aKey: String, dictionary: NSDictionary) -> AnyObject {
        if let object = dictionary.object(forKey: aKey) {
            return object as AnyObject
        } else {
            return "" as AnyObject
        }
    }

    /**
     Check whether strill is nil or not and Returns the string if exist otherwise an empty string as a placeholder for nil value
     
     - Parameter string: String object needs to be checked
     */
	class func checkNilString(_ string: String?) -> String {
		if let tempString = string {
			return tempString
		}
		return ""
	}
	
	// MARK: Network Handling
	class func isConnectedToNetwork() -> Bool {
		let connectionTuple = Reachability.isConnectedToNetwork()
		return connectionTuple.0
	}

	class func isConnectionTypeCellular() -> Bool {
		let connectionTuple = Reachability.isConnectedToNetwork()
		return connectionTuple.1

	}
}

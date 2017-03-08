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

class ETEIndigoUtilities: NSObject {

    // MARK: String Management
	
    func objectOrNilForKey(_ aKey: String, dictionary: NSDictionary) -> AnyObject {
        if let object = dictionary.object(forKey: aKey) {
            return object as AnyObject
        } else {
            return "" as AnyObject
        }
    }

	func checkNilString(_ string: String?) -> String {
		if let tempString = string {
			return tempString
		}
		return ""
	}
	
	// MARK: Network Handling
	func isConnectedToNetwork() -> Bool {
		let connectionTuple = Reachability.isConnectedToNetwork()
		return connectionTuple.0
	}

	func isConnectionTypeCellular() -> Bool {
		let connectionTuple = Reachability.isConnectedToNetwork()
		return connectionTuple.1

	}
}

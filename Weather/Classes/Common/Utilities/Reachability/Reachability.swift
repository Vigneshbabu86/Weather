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
import SystemConfiguration

open class Reachability {

	/*! ------------------------------------------------------------------------------------------------
	 @type Tuple (Bool,Bool)
	 @function isConnectedToNetwork
	 @description verifies if network connectivity is available
	 @param nil
	 ---------------------------------------------------------------------------------------------------- */

	class func isConnectedToNetwork() -> (Bool, Bool) {

		var zeroAddress = sockaddr_in()
		zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
		zeroAddress.sin_family = sa_family_t(AF_INET)
        
		var isConnectionTypeCellular: Bool = false
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return (false,isConnectionTypeCellular)
        }
        
		var flags = SCNetworkReachabilityFlags.connectionAutomatic
		if SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) == false {
			return (false, isConnectionTypeCellular)
		}
		let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
		let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
		if isReachable {
			isConnectionTypeCellular = (flags.contains(.isWWAN))
		}

		return ((isReachable && !needsConnection), isConnectionTypeCellular)
	}
}

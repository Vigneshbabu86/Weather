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

protocol VBWeatherHomeRouterInput {
	func navigateToView()
}

class VBWeatherHomeRouter {
	weak var viewController: VBWeatherHomeViewController!
	
}

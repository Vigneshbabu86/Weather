/**
 * @author Vignesh Babu
 *
 * @brief List of Constants used by the module Weather Launch Screen
 *
 * @version 1.0
 *
 * @copyright Copyright (c) 2017 Vignesh Babu. All rights reserved.
 */
import Foundation

/// Configures the viewcontroller Responsibilities
class VBWeatherHomeConfigurator {
    
    // MARK: Initializers

    fileprivate  init() {
        
    }
    
    /// Returns the shared instance of the VBWeatherHomeConfigurator object
    ///
    static let sharedInstance: VBWeatherHomeConfigurator = {
        let instance = VBWeatherHomeConfigurator()
        // setup code
        return instance
    }()


	// MARK: Configuration
    
    /// Configure the viewcontrooller with the
    /// presenter, interactor and router
    ///
    /// - Parameters:
    ///     - viewController: The viewcontroller needs to be configured
    ///
	func configure(_ viewController: VBWeatherHomeViewController) {
		let presenter = VBWeatherHomePresenter()
		let interactor = VBWeatherHomeInteractor()
		viewController.output = interactor
		interactor.output = presenter
		presenter.output = viewController

	}
}

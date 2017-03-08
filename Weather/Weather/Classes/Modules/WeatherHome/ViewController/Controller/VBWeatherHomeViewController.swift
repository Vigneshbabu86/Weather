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

//MARK: Output Interface
protocol VBWeatherHomeViewControllerOutput {
    func validateCity(_ city: String)
    func searchWeatherForCity(_ city: String)
    func saveLastSearchedCity(_ city: String)
}

class VBWeatherHomeViewController: VBWeatherBaseViewController, VBWeatherHomePresenterOutput {
    // Configurator Input
    var output: VBWeatherHomeViewControllerOutput!
    var router: VBWeatherHomeRouter!
   
    
    // MARK : View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        VBWeatherHomeConfigurator.sharedInstance.configure(self)
    }
    
    // MARK: VBWeatherHomePresenterOutput
    internal func updateViewBasedOnLoginSuccess(_ weatherMap: VBWeatherMap) {
        
    }
    
    internal func updateViewBasedOnLoginFailed(_ title: String?, errorMsg: String!) {
        
    }
    
    internal func hideActivityIndicator() {
        
    }
    
}

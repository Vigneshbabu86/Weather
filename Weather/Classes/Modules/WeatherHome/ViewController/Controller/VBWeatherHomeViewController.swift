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

/// Interacts with presenter and
class VBWeatherHomeViewController: UITableViewController, VBWeatherHomePresenterOutput {
    // Configurator Input
    var output: VBWeatherHomeViewControllerOutput!
    
    // MARK : View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        output.validateCity("iiiiiiii")
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
        // Configure the controller
        VBWeatherHomeConfigurator.sharedInstance.configure(self)
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    
    /*
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
     
     // Configure the cell...
     
     return cell
     }
     */
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
    class func showAlert(_ title: String, message: String, presenter: UIViewController ,actions:() -> ([UIAlertAction])) {
        let alert: UIAlertController =
            UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let alertActions:[UIAlertAction] = actions()
        for action:UIAlertAction in alertActions {
            alert.addAction(action)
        }
        presenter.present(alert, animated: false, completion: nil)
    }
}

// MARK: VBWeatherHomePresenterOutput
typealias WeatherPresenter = VBWeatherHomeViewController
extension WeatherPresenter {
    
    /**
     Handles the success status of the weather request completion
     
     - Parameter weatherMap: Weather Data for the searched city
     */
    internal func updateViewBasedOnWeatherRequestSuccess(_ weatherMap: VBWeatherMap?) {
        print("Weather Map Instance : \(weatherMap)")
    }
    
    /**
     Handles the failure status of the weather request completion
     
     - Parameter title: The alert title needs to be used
     - Parameter error: The error message needs to be displayed
     */
    internal func updateViewBasedOnWeatherRequestFailed(_ title: String? = "", errorMsg: String!) {
        
        if let title = title, let message = errorMsg {
            let CancelAction =
                UIAlertAction(
                    title: "Cancel",
                    style: UIAlertActionStyle.cancel) { (cancelAction:UIAlertAction) in
            }
            
            VBWeatherHomeViewController.showAlert(
                title ,
                message: message ,
                presenter: self) { () -> ([UIAlertAction]) in
                    
                    return [CancelAction]
                    
            }
            
        }
    }
    
    internal func updateViewBasedOnCityTextValidation(_ isSuccess: Bool, errorMsg: String?, cityName: String!) {
        output.searchWeatherForCity(cityName)
    }
    
    internal func hideActivityIndicator() {
        
    }
}

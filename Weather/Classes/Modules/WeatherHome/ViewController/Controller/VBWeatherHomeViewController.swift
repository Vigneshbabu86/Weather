/**
 * @author Vignesh Babu
 *
 * @brief VBWeatherHomeViewController
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

let reuseIdentifierWeatherDescriptionCell = "WeatherDescriptionCell"
let reuseIdentifierWeatherDetailCell = "WeatherDetailCell"

enum WeatherCategory: String {
    case WeatherDescription = "0", Wind = "1", Pressure = "2", Humidity = "3", Sunrise = "4", Sunset = "5", GeoCoords = "6"
    
    func displayString() -> String {
        switch self {
        case .WeatherDescription:
            return "WeatherDescription"
        case .Wind:
            return "Wind"
        case .Pressure:
            return "Pressure"
        case .Humidity:
            return "Humidity"
        case .Sunrise:
            return "Sunrise"
        case .Sunset:
            return "Sunset"
        case .GeoCoords:
            return "GeoCoords"
            
        }
    }
}

/// Interacts with presenter
class VBWeatherHomeViewController: VBWeatherBaseViewController, UITableViewDataSource, UITableViewDelegate, VBWeatherHomePresenterOutput, UISearchBarDelegate {
    
    var weatherTableDataInfo: [String:AnyObject] = [:]
    
    @IBOutlet weak var searchBar: UISearchBar?
    @IBOutlet weak var tableView: UITableView?
    
    // Configurator Input
    var output: VBWeatherHomeViewControllerOutput!
    
    // MARK : View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.searchBar?.delegate = self
        self.searchBar?.layer.masksToBounds = false
        
        tableView?.delegate = self
        tableView?.dataSource = self
        
        self.title = "Weather"

        // Reload the table
        self.tableView?.reloadData()
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
    
    // MARK: - Search Bar Delegates
    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar?.resignFirstResponder()
        self.output.validateCity(searchBar.text ?? "")
        self.weatherTableDataInfo.removeAll()
        DispatchQueue.main.async { [weak self] in
            self?.tableView?.reloadData()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        DispatchQueue.main.async { [weak self] in
            self?.dismiss(animated: true, completion: nil)
        }
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherTableDataInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     var tempRowCell: UITableViewCell!
        switch indexPath.row {
        case 0:
            // Configure the cell...
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifierWeatherDescriptionCell, for: indexPath) as? VBWeatherDescriptionTableViewCell
            let possibleWeatherCategory = WeatherCategory(rawValue: String(indexPath.row))
            if  let weatherCategoryKey = possibleWeatherCategory?.rawValue {
                let weatherMapObject  = self.weatherTableDataInfo[weatherCategoryKey] as? VBWeatherMap
                var temperature = (weatherMapObject!.temperature) ?? 0
                temperature = temperature - 273.15
                cell?.weatherTemperatureLabel?.text = "\(temperature)" + " °C"
                cell?.weatherCityLabel?.text = "Weather in " + (weatherMapObject?.city ?? "")
                cell?.weatherDescriptionLabel?.text = weatherMapObject?.weatherDescription ?? ""
                // Download and set the image asynchronously
                if let weatherIconDownloadURL = weatherMapObject?.iconDownloadURL {
                    cell?.weatherIconImageView?.loadImageUsingCacheWithUrl(urlString: weatherIconDownloadURL)
                }
            }
            
            tempRowCell = cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifierWeatherDetailCell, for: indexPath) as? VBWeatherDetailTableViewCell
            let possibleWeatherCategory = WeatherCategory(rawValue: String(indexPath.row))
            if  let weatherCategoryKey = possibleWeatherCategory?.rawValue {
                cell?.weatherDetailKeyLabel?.text = possibleWeatherCategory?.displayString() ?? ""
                if let valueForKey = self.weatherTableDataInfo[weatherCategoryKey]! as? String {
                    cell?.weatherDetailValueLabel?.text = VBWeatherUtilities.checkNilString(valueForKey)
                }
            }
            
            tempRowCell = cell
            }
        return tempRowCell
     }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row{
        case 0:
            return 255
        default:
            return 68
            }
    }

    
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
    
    
    fileprivate func popupAlert(_ title: String? , errorMessage: String?) {
        if let title = title, let message = errorMessage {
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
    
    func iterateEnum<T: Hashable>(_: T.Type) -> AnyIterator<T> {
        var i = 0
        return AnyIterator {
            let next = withUnsafeBytes(of: &i) { $0.load(as: T.self) }
            if next.hashValue != i { return nil }
            i += 1
            return next
        }
    }
}

// MARK: VBWeatherHomePresenterOutput
typealias WeatherPresenter = VBWeatherHomeViewController
extension WeatherPresenter {
    //[WeatherDescription, Wind, Pressure, Humidity, Sunrise, Sunset, GeoCoords]
    /**
     Handles the success status of the weather request completion
     
     - Parameter weatherMap: Weather Data for the searched city
     */
    internal func updateViewBasedOnWeatherRequestSuccess(_ weatherMap: VBWeatherMap?) {
        print("Weather Map Instance : \(weatherMap)")
        
        // Clear all the data
        self.weatherTableDataInfo.removeAll()
        // Construct Weather Tableview Data from VBWeatherMap instance
//        if weatherMap != nil {
//            self.weatherTableDataInfo[WeatherCategory.WeatherDescription.rawValue] = weatherMap
//            self.weatherTableDataInfo[WeatherCategory.Wind.rawValue] = weatherMap?.windSpeed ?? ""
//            self.weatherTableDataInfo[WeatherCategory.Pressure.rawValue] = weatherMap?.pressure ?? ""
//            self.weatherTableDataInfo[WeatherCategory.Humidity.rawValue] = weatherMap?.humidity ?? ""
//            self.weatherTableDataInfo[WeatherCategory.Sunrise.rawValue] = weatherMap?.sunrise ?? ""
//            self.weatherTableDataInfo[WeatherCategory.Sunset.rawValue] = weatherMap?.sunset ?? ""
//            let latitude =  (weatherMap?.latitude) ?? 0
//            let longitude = weatherMap?.longitude ?? 0
//            let geoCordinates = "[" + "\(latitude)" + "," + "\(longitude)" + "]"
//            self.weatherTableDataInfo[WeatherCategory.GeoCoords.rawValue] = geoCordinates
//
//        }
        
        if weatherMap != nil {
            for weatherCategory in iterateEnum(WeatherCategory.self) {
                switch weatherCategory {
                case .WeatherDescription:
                    self.weatherTableDataInfo[WeatherCategory.WeatherDescription.rawValue] = weatherMap!
                case .Wind:
                    let windSpeed = (weatherMap!.windSpeed) ?? 0
                    self.weatherTableDataInfo[WeatherCategory.Wind.rawValue] = "\(windSpeed)" + " m/s" as AnyObject?
                case .Pressure:
                    let pressure = (weatherMap!.pressure) ?? 0
                    self.weatherTableDataInfo[WeatherCategory.Pressure.rawValue] = "\(pressure)" as AnyObject?
                case .Humidity:
                    let humidity = (weatherMap!.humidity) ?? 0
                    self.weatherTableDataInfo[WeatherCategory.Humidity.rawValue] = "\(humidity)" as AnyObject?
                case .Sunrise:
                    let sunriseTime = VBWeatherUtilities.getDateAndTimeComponentsFromDate(weatherMap!.sunrise)
                    self.weatherTableDataInfo[WeatherCategory.Sunrise.rawValue] = sunriseTime as AnyObject?
                case .Sunset:
                    let sunsetTime = VBWeatherUtilities.getDateAndTimeComponentsFromDate(weatherMap!.sunset)
                    self.weatherTableDataInfo[WeatherCategory.Sunset.rawValue] = sunsetTime as AnyObject?
                case .GeoCoords:
                    let latitude =  (weatherMap?.latitude) ?? 0
                    let longitude = weatherMap?.longitude ?? 0
                    let geoCordinates = "[" + "\(latitude)" + "," + "\(longitude)" + "]"
                    self.weatherTableDataInfo[WeatherCategory.GeoCoords.rawValue] = geoCordinates as AnyObject?
                    
                }
            }
        }
        
        
        self.tableView?.reloadData()
    }
    
    /**
     Handles the failure status of the weather request completion
     
     - Parameter title: The alert title needs to be used
     - Parameter error: The error message needs to be displayed
     */
    internal func updateViewBasedOnWeatherRequestFailed(_ title: String? = "", errorMsg: String?) {
        popupAlert(title, errorMessage: errorMsg)
    }
    
    internal func updateViewBasedOnCityTextValidation(_ isSuccess: Bool, errorMsg: String?, cityName: String!) {
        if isSuccess {
            output.searchWeatherForCity(cityName)
        }
        else {
             popupAlert("", errorMessage: errorMsg)
        }
    }
    
    internal func hideActivityIndicator() {
        
    }
}

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
    func getLastSearchedCity() -> String 
}

let reuseIdentifierWeatherDescriptionCell = "WeatherDescriptionCell"
let reuseIdentifierWeatherDetailCell = "WeatherDetailCell"

/// Weather Enum to Manage the Order of Display
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

/// Interacts with presenter and handles the UI
class VBWeatherHomeViewController: VBWeatherBaseViewController, UITableViewDataSource, UITableViewDelegate, VBWeatherHomePresenterOutput, UISearchBarDelegate {
   
    @IBOutlet weak var searchBar: UISearchBar?
    @IBOutlet weak var tableView: UITableView?
    
    /// Manage Weather entries for display
    var weatherTableDataInfo: [String:AnyObject] = [:]
    
    // Configurator Input
    var output: VBWeatherHomeViewControllerOutput!
    
    /// Activity Indicator View
    var activityIndicator: UIActivityIndicatorView?
    
    /// View Loaded Status
    var isViewLoadingCompletedForPreviousSearchCompleted = false
    
    // MARK : View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.searchBar?.delegate = self
        self.searchBar?.layer.masksToBounds = false
        
        tableView?.delegate = self
        tableView?.dataSource = self
        
        // set the title
        self.title = "Weather"

        // Reload the table
        self.tableView?.reloadData()
        
        
        activityIndicator = UIActivityIndicatorView(frame:CGRect(x: 100, y: 100, width: 100, height: 100)) as UIActivityIndicatorView
        self.activityIndicator?.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        self.activityIndicator?.center = self.view.center;
        self.view.addSubview(activityIndicator!);
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if (isViewLoadingCompletedForPreviousSearchCompleted == false) {
            self.isViewLoadingCompletedForPreviousSearchCompleted = true
            let lastSearchedCity = self.output.getLastSearchedCity()
            if lastSearchedCity.characters.count > 0 {
                self.output.validateCity(lastSearchedCity)
            }
        }
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
        self.startActivityIndicator()
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
    
    func startActivityIndicator() {
        self.activityIndicator?.startAnimating()
    }
}

// MARK: VBWeatherHomePresenterOutput
typealias WeatherPresenter = VBWeatherHomeViewController
extension WeatherPresenter {
    
    func iterateEnum<T: Hashable>(_: T.Type) -> AnyIterator<T> {
        var i = 0
        return AnyIterator {
            let next = withUnsafeBytes(of: &i) { $0.load(as: T.self) }
            if next.hashValue != i { return nil }
            i += 1
            return next
        }
    }
    
    /**
     Handles the success status of the weather request completion
     
     - Parameter weatherMap: Weather Data for the searched city
     */
    internal func updateViewBasedOnWeatherRequestSuccess(_ weatherMap: VBWeatherMap?) {
        print("Weather Map Instance : \(weatherMap)")
        
        // Clear all the data
        self.weatherTableDataInfo.removeAll()
        
        // Construct Weather Tableview Data from VBWeatherMap instance
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
        self.hideActivityIndicator()
        
        // save the last searched city in history
        let citySearched = weatherMap?.city ?? ""
        self.output.saveLastSearchedCity(citySearched)
    }
    
    /**
     Handles the failure status of the weather request completion
     
     - Parameter title: The alert title needs to be used
     - Parameter error: The error message needs to be displayed
     */
    internal func updateViewBasedOnWeatherRequestFailed(_ title: String? = "", errorMsg: String?) {
        self.hideActivityIndicator()
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
        self.activityIndicator?.stopAnimating()
    }
}

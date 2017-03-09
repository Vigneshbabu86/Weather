/**
 * @author Vignesh Babu
 *
 * @brief Weather Description Cell
 *
 * @version 1.0
 *
 * @copyright Copyright (c) 2017 Vignesh Babu. All rights reserved.
 */

import UIKit

class VBWeatherDescriptionTableViewCell: UITableViewCell {

    @IBOutlet weak var weatherCityLabel: UILabel?
    @IBOutlet weak var weatherTemperatureLabel: UILabel?
    @IBOutlet weak var weatherDescriptionLabel: UILabel?
    @IBOutlet weak var weatherIconImageView: UIImageView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

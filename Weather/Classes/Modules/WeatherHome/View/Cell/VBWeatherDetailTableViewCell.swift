/**
 * @author Vignesh Babu
 *
 * @brief Weather Details Cell for each entry
 *
 * @version 1.0
 *
 * @copyright Copyright (c) 2017 Vignesh Babu. All rights reserved.
 */

import UIKit

class VBWeatherDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var weatherDetailKeyLabel: UILabel?
    @IBOutlet weak var weatherDetailValueLabel: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

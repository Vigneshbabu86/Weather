/**
 * @author Vignesh Babu
 *
 * @brief Extends the UIImageview functionality with asynchronous image loading
 *
 * @version 1.0
 *
 * @copyright Copyright (c) 2017 Vignesh Babu. All rights reserved.
 */
import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    func loadImageUsingCacheWithUrl(urlString: String) {
        self.image = nil
        
        // check for cache
        if let cachedImage = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = cachedImage
            return
        }
        
        // download image from url
        let url = URL(string: urlString)
        
            
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) -> Void in
            guard let data = data, error == nil else {
                print("\nerror on download \(error)")
                return
            }
            
            DispatchQueue.main.async(execute: { () -> Void in
                if let image = UIImage(data: data) {
                    imageCache.setObject(image, forKey: urlString as AnyObject)
                    self.image = image
                }
                
            })
        }).resume()
    }
}

//
//  CachingImageView.swift
//  RunUp
//
//  Created by Bartosz Pawełczyk on 18/10/2018.
//  Copyright © 2018 Bartosz Pawełczyk. All rights reserved.
//

import UIKit

let imgCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    
    func loadImageUsingCache(urlString: String) {
        
        if let cachedImage = imgCache.object(forKey: urlString as NSString) as? UIImage {
            self.image = cachedImage
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if error != nil {
                debugPrint(error!.localizedDescription)
            }
            
            DispatchQueue.main.async {
                let image = UIImage(data: data!)
                
                imgCache.setObject(image!, forKey: urlString as NSString)
                
                self.image = image
            }
        }.resume()
    }
    
}

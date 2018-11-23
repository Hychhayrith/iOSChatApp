//
//  Extension.swift
//  iosChatApp
//
//  Created by Chhayrith on 11/23/18.
//  Copyright © 2018 Chhayrith. All rights reserved.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    func loadImageUsingCacheWithUrlString(urlString: String){
        // first, before image load set it to nil so that it is clean
        self.image = nil
        
        // check if image already in the cache. Then add the image to self
        if let cachedImage = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = cachedImage
            return
        }
        
        // otherwise download the image and store to cache
        let profileUrl = URL(string: urlString)
        URLSession.shared.dataTask(with: profileUrl!, completionHandler: {(data, response, error) in
            if let error = error {
                print(error)
                return
            }
            DispatchQueue.main.async {
                if let downloadedImage = UIImage(data: data!){
                    imageCache.setObject(downloadedImage, forKey: urlString as AnyObject)
                    self.image = downloadedImage
                }
            }
        }).resume()
    }
    
}

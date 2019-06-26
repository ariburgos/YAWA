//
//  ImageManager.swift
//  YAWA
//
//  Created by Viajeros Lado B on 25/06/2019.
//  Copyright © 2019 DragonShine. All rights reserved.
//

import Foundation
import UIKit

struct ImageManager {
    static let shared = ImageManager()
    private init() { }
    
    private let imageCache = NSCache<AnyObject, AnyObject>()

    func getImageFromForecastAPI(named: String, completion: @escaping (UIImage?) -> ()) {
        if let imageFromCache = imageCache.object(forKey: named as AnyObject) as? UIImage {
            completion(imageFromCache)
            return
        }

        ForecastAPI.shared.getIcon(named: named) {(data, error) in
            guard let data = data,
                let image = UIImage(data: data) else { return }
            
            self.imageCache.setObject(image, forKey: named as AnyObject)
            completion(image)
        }
    }
}

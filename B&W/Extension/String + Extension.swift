//
//  String + Extension.swift
//  B&W
//
//  Created by cleopatra on 2024/4/23.
//  Copyright © 2024 Artemis Simple Solutions Ltd. All rights reserved.
//

import UIKit

extension String {
    
    func convertUrlToImage() -> UIImage? {
        var image: UIImage?
        
        if let url = URL(string: self){
            
            URLSession.shared.dataTask(with: url, completionHandler: { (data, responseDecoder, error) in
                // Fetch Image Data
                guard let data = try? Data(contentsOf: url) else { return }
                    image = UIImage(data: data)
            }).resume()
        }
        return image
    }
    
}

//
//  ProductDetailsSwiftUIViewModel.swift
//  B&W
//
//  Created by cleopatra on 2024/4/23.
//  Copyright © 2024 Artemis Simple Solutions Ltd. All rights reserved.
//

import Foundation

//protocol ProductDetailsSwiftUIViewModelInput {
//    func updateImage()
//}

protocol ProductDetailsSwiftUIViewModelOutput {
    var name: String { get }
    var image: String { get }
    var description: String { get }
    var price: String { get }
}

protocol ProductDetailsSwiftUIViewModel: ProductDetailsSwiftUIViewModelOutput { }

// 🦞
final class DefaultProductDetailsSwiftUIViewModel: ProductDetailsSwiftUIViewModel {

    let name: String
    let image: String
    let description: String
    let price: String

    init(product: Product) {
        self.name = product.name ?? ""
        self.description = product.description ?? ""
        self.image = product.imagePath ?? ""
        self.price = product.price ?? ""
    }
}

//extension DefaultProductDetailsSwiftUIViewModel {
//    func updateImage() {
//        guard let imagePath = imagePath else { return }
//
//        let url = URL(string: imagePath)!
//
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            
//            // Fetch Image Data
//            if let data = try? Data(contentsOf: url) {
//                DispatchQueue.main.async {
//                    // Create Image and Update Image View
//                    self.image.value = data
//                }
//                
//            }
//        }.resume()
//        
//    }
//}

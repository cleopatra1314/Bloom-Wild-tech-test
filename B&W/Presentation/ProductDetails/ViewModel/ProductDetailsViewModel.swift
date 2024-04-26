import Foundation
import UIKit

protocol ProductDetailsViewModelInput {
    func updateImage()
}

protocol ProductDetailsViewModelOutput {
    var name: String { get }
//    var image: Observable<Data?> { get }
//    var image: Data? { get }
    var description: String { get }
    var rating: Double { get }
    var price: String { get }
}

protocol ProductDetailsViewModel: ProductDetailsViewModelInput, ProductDetailsViewModelOutput { }

// 🦞
let imageCache = NSCache<NSURL, UIImage>()

final class DefaultProductDetailsViewModel: ObservableObject, ProductDetailsViewModel {

    @Published var imageData: Data?
    
    let imagePath: String?

    let name: String
//    let image: Observable<Data?> = Observable(nil)
//    var image: String
    let description: String
    let rating: Double
    let price: String

    init(product: Product) {
        self.name = product.name ?? ""
        self.description = product.description ?? ""
        self.imagePath = product.imagePath
        self.rating = product.rating ?? 0.0
        self.price = product.price ?? ""
    }
}

extension DefaultProductDetailsViewModel {
    
    func updateImage() {
        
        guard let imagePath = imagePath else { return }
        guard imageData == nil else { return }

        if let url = URL(string: imagePath) {

            if let cachedImageData = imageCache.object(forKey: url as NSURL) {
                            
            } else {
                URLSession.shared.dataTask(with: url) { data, response, error in
                    
                    // Fetch Image Data
                    if let data = try? Data(contentsOf: url) {
                        DispatchQueue.main.async {
                            // Create Image and Update Image View
                            self.imageData = data
                        }
                        
                    }
                }.resume()
            }
        }
        
    }
}

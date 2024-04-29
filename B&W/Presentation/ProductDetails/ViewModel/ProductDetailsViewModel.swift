import Foundation
import UIKit

protocol ProductDetailsViewModelInput {
//    func updateImage()
}

protocol ProductDetailsViewModelOutput {
    var name: String { get }
    var description: String { get }
    var rating: Double { get }
    var price: String { get }
}

protocol ProductDetailsViewModel: ProductDetailsViewModelInput, ProductDetailsViewModelOutput { }


final class DefaultProductDetailsViewModel: ProductDetailsViewModel, ObservableObject {

    @Published var imageData: Data?
    
    let imagePath: String?

    let name: String
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

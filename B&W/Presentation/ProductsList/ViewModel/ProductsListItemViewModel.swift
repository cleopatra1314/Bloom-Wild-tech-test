import UIKit

class ProductsListItemViewModel {
    
    var networkService: DefaultNetworkService?
    
    let name: String
    let price: String
    let description: String
    let imagePath: String
    var imageData: Data?

    init(product: Product) {
        self.name = product.name ?? ""
        self.price = product.price ?? ""
        self.description = product.description ?? ""
        self.imagePath = product.imagePath ?? ""
    }
    
    // Changes: Move networking to viewModel by following MVVM
    // Changes: Apply DefaultNetworkService to make image url string to UIImage
    
    /// Load image by converting image url string to UIImage.
    /// - Parameter completion: Sending UIImage and image data
    func imageUrlStringToUIImage(completion: @escaping (UIImage?, Data?) -> Void) {

        if let url = URL(string: imagePath){

            let urlRequest = URLRequest(url: url)
            let requestConfig = ApiRequestConfig(baseURL: url)
            networkService = DefaultNetworkService(config: requestConfig)
            
            _ = networkService!.request(request: urlRequest) { result in
                switch result {
                case .success(let data):
                    if let data = data {
                        
                        self.imageData = data
        
                        let image = UIImage(data: data)
                        completion(image, data)
                        
                    }
                case .failure(let error):
                    completion(nil, nil)
                    print("Error fetching image: \(error)")
                            }
            }

        }
        
    }
}



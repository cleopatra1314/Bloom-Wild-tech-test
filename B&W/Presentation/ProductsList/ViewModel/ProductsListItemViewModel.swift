import UIKit

class ProductsListItemViewModel {
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
//        self.imageData = product.imageData!
    }
    
    // MARK: Use URLSession to call API out from main thread.
    func imageUrlStringToUIImage(completion: @escaping (UIImage?, Data?) -> Void) {
        
        if let url = URL(string: self.imagePath) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                // 檢查是否有錯誤
                guard let data = data, error == nil else {
                    print("Error fetching image:", error ?? "Unknown error")
                    completion(nil, nil) // 傳遞 nil 以指示出現錯誤
                    return
                }
                self.imageData = data
                // 創建圖像並將其傳遞給 completion handler
                let image = UIImage(data: data)
                completion(image, data)
            }.resume()
        } else {
            completion(nil, nil) // 傳遞 nil 以指示 URL 錯誤
        }
        
    }
}



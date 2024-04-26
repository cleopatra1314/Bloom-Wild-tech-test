import UIKit

class ProductsListItemViewModel {
    let name: String
    let price: String
    let description: String
    let imagePath: String
    let imageData = Data()

    init(product: Product) {
        self.name = product.name ?? ""
        self.price = product.price ?? ""
        self.description = product.description ?? ""
        self.imagePath = product.imagePath ?? ""
    }
    
    // MARK: Use URLSession to call API out from main thread.
    func imageUrlStringToUIImage(completion: @escaping (UIImage?) -> Void) {
        
        if let url = URL(string: self.imagePath) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                // 檢查是否有錯誤
                guard let data = data, error == nil else {
                    print("Error fetching image:", error ?? "Unknown error")
                    completion(nil) // 傳遞 nil 以指示出現錯誤
                    return
                }
                // 創建圖像並將其傳遞給 completion handler
                let image = UIImage(data: data)
                completion(image)
            }.resume()
        } else {
            completion(nil) // 傳遞 nil 以指示 URL 錯誤
        }
        
    }
}



import UIKit

final class ProductListItemCell: UITableViewCell {

    static let reuseIdentifier = String(describing: ProductListItemCell.self)
    static let height = CGFloat(140)

    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var priceLabel: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!
    @IBOutlet private var productImageView: UIImageView!

    private var viewModel: ProductsListItemViewModel!
    var imageData: Data!

    func fill(with viewModel: ProductsListItemViewModel) {
        self.viewModel = viewModel

        nameLabel.text = viewModel.name
        priceLabel.text = viewModel.price.description
        descriptionLabel.text = viewModel.description
        
        viewModel.imageUrlStringToUIImage { image, imageData in
            if let image = image {
                
                // 成功加載圖像，使用圖像
                // 例如，設置圖像視圖的圖像：
                DispatchQueue.main.async {
                    self.imageData = imageData
                    self.productImageView.image = image
                }
                
            } else {
                // 圖像加載失敗，執行錯誤處理邏輯
                print("Failed to load image")
            }
        }

    }


}

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
                
                // Changes: UI updating should be done on mian thread
                
                DispatchQueue.main.async {
                    self.imageData = imageData
                    self.productImageView.image = image
                }
                
            } else {
                print("Failed to load image")
            }
        }

    }


}

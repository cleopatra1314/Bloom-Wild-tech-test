import UIKit
import SwiftUI

class ProductDetailsViewController: UIViewController, StoryboardInstantiable {

    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productDescriptionTextView: UITextView!

    private var viewModel: DefaultProductDetailsViewModel!

    static func create(with viewModel: ProductDetailsViewModel) -> ProductDetailsViewController {
        let view = ProductDetailsViewController.instantiateViewController()
        view.viewModel = viewModel as! DefaultProductDetailsViewModel
        return view
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bind(to: viewModel)
    }

    // WARNING: func viewDidLayoutSubviews is called twice.
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        viewModel.updateImage()
    }

    private func bind(to viewModel: DefaultProductDetailsViewModel) {
//        viewModel.imageData.observe(on: self) { [weak self] in
//            self?.productImageView.image = $0.flatMap(UIImage.init) }
    }

    private func setupViews() {
        title = viewModel.name
        productPriceLabel.text = viewModel.price
        productDescriptionTextView.text = viewModel.description

    }
}

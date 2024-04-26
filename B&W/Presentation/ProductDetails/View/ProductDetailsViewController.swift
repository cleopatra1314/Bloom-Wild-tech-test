import UIKit
import SwiftUI

class ProductDetailsViewController: UIViewController, StoryboardInstantiable {

    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productDescriptionTextView: UITextView!

    private var viewModel: DefaultProductDetailsViewModel!
    var imageData: Data!

    static func create(with viewModel: ProductDetailsViewModel, imageData: Data) -> ProductDetailsViewController {
        let view = ProductDetailsViewController.instantiateViewController()
        view.viewModel = viewModel as! DefaultProductDetailsViewModel
        view.imageData = imageData
        return view
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
//        bind(to: viewModel)
    }

    // WARNING: func viewDidLayoutSubviews is called twice.
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        viewModel.updateImage()
//    }
//
//    private func bind(to viewModel: DefaultProductDetailsViewModel) {
////        viewModel.imageData.observe(on: self) { [weak self] in
////            self?.productImageView.image = $0.flatMap(UIImage.init) }
//    }

    private func setupViews() {
        
        let childVC = UIHostingController(rootView: ProductDetailsSwiftUIView(viewModel: viewModel, imageData: imageData))
        self.addChild(childVC)
        self.view.addSubview(childVC.view)
        childVC.didMove(toParent: self)
        childVC.view.frame = self.view.frame

    }
}

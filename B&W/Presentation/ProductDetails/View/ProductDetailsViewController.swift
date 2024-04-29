import UIKit
import SwiftUI

// Changes: Modify hierachy of product details screen: ProductDetailsViewController(parentVC) -> UIHostingController(childVC) -> ProductDetailsSwiftUIView

class ProductDetailsViewController: UIViewController {

    private var viewModel: DefaultProductDetailsViewModel!
    var imageData: Data!

    static func create(with viewModel: ProductDetailsViewModel, imageData: Data) -> ProductDetailsViewController {
        let view = ProductDetailsViewController()
        view.viewModel = viewModel as? DefaultProductDetailsViewModel
        view.imageData = imageData
        return view
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    private func setupViews() {
        
        self.navigationItem.title = viewModel.name
        
        let childVC = UIHostingController(rootView: ProductDetailsView(viewModel: viewModel, imageData: imageData))
        self.addChild(childVC)
        self.view.addSubview(childVC.view)
        childVC.view.frame = self.view.frame

    }
}

import Foundation
import UIKit

final class DependencyContainer: GetProductsFlowCoordinatorDependencies {

    struct Dependencies {
        let apiDataTransferService: DataTransferService
    }

    private let dependencies: Dependencies

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }

    // MARK: - Use Cases

    func makeGetProductsUseCase() -> GetProductsUseCase {
        return DefaultGetProductsUseCase(productsRepository: makeProductsRepository())
    }

    // MARK: - Repositories

    func makeProductsRepository() -> ProductsRepository {
        return DefaultProductsRepository(dataTransferService: dependencies.apiDataTransferService)
    }

    // MARK: - Controllers

    func makeProductsListViewController(actions: ProductsListViewModelActions) -> ProductsListViewController {
        return ProductsListViewController.create(with: makeProductsListViewModel(actions: actions))
    }

    func makeProductDetailsViewController(product: Product, imageData: Data) -> ProductDetailsViewController {

        return ProductDetailsViewController.create(with: makeProductDetailsViewModel(product: product), imageData: imageData)
    }
    
    // 🦞For SwiftUI
    func makeProductDetailsSwiftUIView(product: Product, imageData: Data) -> ProductDetailsSwiftUIView {

        let productDetailsSUView = ProductDetailsSwiftUIView(viewModel: makeProductDetailsViewModel(product: product) as! DefaultProductDetailsViewModel, imageData: imageData)
        
        return productDetailsSUView
    }

    // MARK: - View Models

    func makeProductsListViewModel(actions: ProductsListViewModelActions) -> ProductsListViewModel {
        return DefaultProductsListViewModel(useCase: makeGetProductsUseCase(),
                                          actions: actions)
    }

    func makeProductDetailsViewModel(product: Product) -> ProductDetailsViewModel {
        return DefaultProductDetailsViewModel(product: product)
    }
    
    func makeProductDetailsSwiftUIView(product: Product) -> DefaultProductDetailsSwiftUIViewModel {
        return DefaultProductDetailsSwiftUIViewModel(product: product)
    }

    // MARK: - Flow Coordinators
    func makeGetProductsFlowCoordinator(tabBarController: UITabBarController, navigationController: UINavigationController) -> GetProductsFlowCoordinator {
        return GetProductsFlowCoordinator(tabBarController: tabBarController, navigationController: navigationController,
                                          dependencies: self)
    }
}

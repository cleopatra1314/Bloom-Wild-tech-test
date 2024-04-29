import Foundation

struct ProductsListViewModelActions {
    
    // Changes: Reduce the times of sending request by sending image data
    let showProductDetails: (Product, Data) -> Void
//    let showProductImage: (Data) -> Void
}

protocol ProductsListViewModelInput {
    func viewDidLoad()
    func didSelectItem(at index: Int)
}

protocol ProductsListViewModelOutput {
    var items: Observable<[ProductsListItemViewModel]> { get }
    var error: Observable<String> { get }
    var query: String { get }
    var isEmpty: Bool { get }
}

protocol ProductsListViewModel: ProductsListViewModelInput, ProductsListViewModelOutput {}

final class DefaultProductsListViewModel: ProductsListViewModel {

    // MARK: - OUTPUT

    let items: Observable<[ProductsListItemViewModel]> = Observable([])

    let error: Observable<String> = Observable("")

    var query: String = ""

    var isEmpty: Bool { return items.value.isEmpty }

    private let useCase: GetProductsUseCase

    private let actions: ProductsListViewModelActions?

    private var loadTask: Cancellable? { willSet { loadTask?.cancel() } }

    var products: [Product] = []
    
    var productImageData: [Data] = []

    // MARK: - Init

    init(useCase: GetProductsUseCase, actions: ProductsListViewModelActions? = nil) {
        self.useCase = useCase
        self.actions = actions
    }

    private func load(productQuery: ProductQuery) {

        query = productQuery.query

        loadTask = useCase.execute(
            requestValue: .init(query: productQuery),
            completion: { result in
                switch result {
                case .success(let data):
                    self.products = data.products
                    self.items.value = data.products.map(ProductsListItemViewModel.init)
                    
                case .failure(let error):
                    self.error.value = error.isInternetConnectionError ?
                        NSLocalizedString("No internet connection", comment: "") :
                        NSLocalizedString("Failed loading products", comment: "")
                }
        })
    }
    

}

// MARK: - INPUT. View event methods

extension DefaultProductsListViewModel {
    func viewDidLoad() {
        load(productQuery: .init(query: query))
    }

    func didSelectItem(at index: Int) {
        actions?.showProductDetails(products[index], items.value[index].imageData!)
//        actions?.showProductImage(productImageData[index])
    }
}

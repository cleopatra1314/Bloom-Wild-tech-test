import SwiftUI


// Changes: SwiftUI migration of product details screen

struct ProductDetailsView: View {
    
    // Changes: Keep the original setting of observing data of image
    @ObservedObject var viewModel: DefaultProductDetailsViewModel
    var imageData: Data!

    var body: some View {
            VStack(spacing: 16.0) {
                if let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                }
                Label(viewModel.price, systemImage: "dollarsign.circle")
                HStack(spacing: 16.0) {
                    let rating = viewModel.rating
                    if rating != 0.0 {
                        Text(viewModel.rating.description)
                        StarsView(rating: viewModel.rating, maxRating: 5)
                            .frame(width: 100)
                    } else {
                        Text("No rating")
                    }
                }
                Text(viewModel.description)
                    .multilineTextAlignment(.leading)
                    .lineLimit(0)
            }
        .padding(.horizontal, 24.0)
        .padding(.top, 0.0)
        .navigationTitle(viewModel.name)
        
    }
}

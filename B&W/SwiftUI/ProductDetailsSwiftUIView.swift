import SwiftUI

struct ProductDetailsSwiftUIView: View {
    @ObservedObject var viewModel: DefaultProductDetailsViewModel
    
//    init(viewModel: DefaultProductDetailsViewModel) {
//        self.viewModel = viewModel
//    }

    var body: some View {
        VStack(spacing: 16.0) {
            if let imageData = viewModel.imageData, let uiImage = UIImage(data: imageData) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFit()
//                                .aspectRatio(contentMode: .fit)
//                                .frame(height: 200)
                        } else {
                            // Placeholder or loading indicator can be added here
                            Text("Loading Image...")
                        }
//            Image(uiImage: UIImage.init(data: viewModel.)!))
//            AsyncImage(url: URL(string: viewModel.image)) { phase in
//                        if let image = phase.image {
//                            image
//                                .resizable()
//                        } else if phase.error != nil {
//                            Image(systemName: "questionmark.circle.fill")
//                                .resizable()
//                        } else {
//                            Color.gray
//                        }
//                    }
//                    .scaledToFit()
//                    .frame(width: 300, height: 300)
                
            Label(viewModel.price, systemImage: "dollarsign.circle")
            HStack(spacing: 16.0) {
                Text(viewModel.rating.description)
                StarsView(rating: viewModel.rating, maxRating: 5)
                    .frame(width: 100)
            }
            Text(viewModel.description)
                .multilineTextAlignment(.leading)
                .lineLimit(0)
        }
        .onAppear {
                    viewModel.updateImage()
                }
        .padding(.horizontal, 24.0)
        .padding(.top, 0.0)
        .navigationTitle(viewModel.name)
        
    }
}

//#Preview {
//    ProductDetailsSwiftUIView(viewModel: <#DefaultProductDetailsViewModel#>)
//}

//struct ProductDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
////        let product = Product(id: "Sample Product", name: "Sample Product", description: "Sample Description", price: "$10", imagePath: "https://example.com/sample-image.jpg")
////        let viewModel = DefaultProductDetailsViewModel(product: product)
////        return NavigationView {
////            ProductDetailsSwiftUIView()
////        }
//        ProductDetailsSwiftUIView(viewModel: )
//    }
//}

struct StarsView: View {
    var rating: CGFloat
    var maxRating: Int

    var body: some View {
        let stars = HStack(spacing: 0) {
            ForEach(0..<maxRating, id: \.self) { _ in
                Image(systemName: "star.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
        }

        stars.overlay(
            GeometryReader { g in
                let width = rating / CGFloat(maxRating) * g.size.width
                ZStack(alignment: .leading) {
                    Rectangle()
                        .frame(width: width)
                        .foregroundColor(.yellow)
                }
            }
            .mask(stars)
        )
        .foregroundColor(.gray)
    }
}

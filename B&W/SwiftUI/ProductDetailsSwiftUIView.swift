//
//  SwiftUIView.swift
//  B&W
//
//  Created by cleopatra on 2024/4/23.
//  Copyright © 2024 Artemis Simple Solutions Ltd. All rights reserved.
//

import SwiftUI


struct ProductDetailsSwiftUIView: View {
    var viewModel: ProductDetailsSwiftUIViewModel!
    
    var body: some View {
        VStack(spacing: 16.0) {
            AsyncImage(url: URL(string: viewModel.image)) { phase in
                        if let image = phase.image {
                            image
                                .resizable()
                        } else if phase.error != nil {
                            Image(systemName: "questionmark.circle.fill")
                                .resizable()
                        } else {
                            Color.gray
                        }
                    }
                    .scaledToFit()
                    .frame(width: 300, height: 300)
                
            Label(viewModel.price, systemImage: /*@START_MENU_TOKEN@*/"42.circle"/*@END_MENU_TOKEN@*/)
            Text(viewModel.description)
                .multilineTextAlignment(.leading)
                .lineLimit(0)
        }
        .padding(.horizontal, 16.0)
        .padding(.top, 0.0)
        
    }
}

#Preview {
    ProductDetailsSwiftUIView()
}

//
//  SwiftUIView.swift
//  B&W
//
//  Created by cleopatra on 2024/4/23.
//  Copyright © 2024 Artemis Simple Solutions Ltd. All rights reserved.
//

import SwiftUI

struct ProductDetailsSwiftUIView: View {
    var body: some View {
        VStack(spacing: 16.0) {
            Image("p1")
                .resizable()
                .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fit/*@END_MENU_TOKEN@*/)
                
                
            Label("name", systemImage: /*@START_MENU_TOKEN@*/"42.circle"/*@END_MENU_TOKEN@*/)
            Text("Description")
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

//
//  PromoCardView.swift
//  ANF Code Test
//
//  Created by Chris Jarvi on 1/13/23.
//

import SwiftUI

struct PromoCardView: View {
    @State var imageName: String? = "anf-US-20160518-app-men-tees"
    @State var topDescription: String? = "A & F Essentials"
    @State var title: String? = "Tops Starting at $12"
    @State var promoMessage: String? = "Use Code: 12345"
    @State var bottomDescription: String? = "*In stores & online. "
    @State var bottomDescriptionUnderlined: String? = "Exclusions apply. See Details"
    @State var content: [ContentItem] = [
        ContentItem(elementType: nil, target: "", title: "Shop Men"),
        ContentItem(elementType: nil, target: "", title: "Shop Women")
    ]
    
    var body: some View {
        VStack(spacing: 10) {
            if let imageName {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
            }
            
            if let topDescription {
                Text(topDescription)
                    .textCase(.uppercase)
            }
            
            if let title {
                Text(title)
                    .font(.system(size: 17, weight: .bold))
                    .textCase(.uppercase)
            }
            
            if let promoMessage {
                Text(promoMessage)
                    .font(.system(size: 11))
            }
            
            if ![bottomDescription, bottomDescriptionUnderlined].compactMap({ $0 }).isEmpty {
                HStack(spacing: 0) {
                    if let bottomDescription {
                        Text(bottomDescription)
                    }
                    if let bottomDescriptionUnderlined {
                        Text(bottomDescriptionUnderlined)
                            .underline()
                    }
                }
            }
            
            ForEach(content, id: \.self) { item in
                Button {
                    
                } label: {
                    Text(item.title)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .font(.system(size: 15))
                }
                .buttonStyle(.plain)
                .border(.gray)
            }
        }
        .font(.system(size: 13))
        .padding()
    }
}

struct PromoCardView_Previews: PreviewProvider {
    static var previews: some View {
        PromoCardView()
    }
}

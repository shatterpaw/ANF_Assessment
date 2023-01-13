//
//  PromoCardView.swift
//  ANF Code Test
//
//  Created by Chris Jarvi on 1/13/23.
//

import SwiftUI

struct PromoCardView: View {
    @State var promoItem: PromoItem
    
    var body: some View {
        VStack(spacing: 10) {
            if let imageName = promoItem.backgroundImageName?.stripFileExtension() {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
            }
            
            if let topDescription = promoItem.topDescription {
                Text(topDescription)
                    .textCase(.uppercase)
            }
            
            if let title = promoItem.title {
                Text(title)
                    .font(.system(size: 17, weight: .bold))
                    .textCase(.uppercase)
            }
            
            if let promoMessage = promoItem.promoMessage {
                Text(promoMessage)
                    .font(.system(size: 11))
            }
            
            /*
             For this assessment, html links are not followed
             */
            if let bottomDescription = try? promoItem.bottomDescription?.htmlToAttributedString(font: .systemFont(ofSize: 13)) {
                Text(bottomDescription)
            }
            
            ForEach(promoItem.content ?? [], id: \.self) { item in
                Button {
                    
                } label: {
                    Text(item.title)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .font(.system(size: 15))
                }
                .buttonStyle(.plain)
                .border(.gray)
                .padding([.leading, .trailing])
            }
        }
        .font(.system(size: 13))
        .padding()
    }
}

struct PromoCardView_Previews: PreviewProvider {
    static var promoItem: PromoItem {
        PromoItem(title: "Tops Starting at $12",
                  backgroundImageName: "anf-US-20160518-app-men-tees",
                  promoMessage: "Use Code: 12345",
                  topDescription: "A & F Essentials",
                  bottomDescription: "*In stores & online. Exclusions apply. See Details",
                  content: [
                    ContentItem(elementType: nil, target: "", title: "Shop Men"),
                    ContentItem(elementType: nil, target: "", title: "Shop Women")
                  ])
    }
    static var previews: some View {
        PromoCardView(promoItem: promoItem)
    }
}

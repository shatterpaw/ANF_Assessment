//
//  PromoCardView.swift
//  ANF Code Test
//
//  Created by Chris Jarvi on 1/13/23.
//

import SwiftUI

struct PromoCardView: View {
    @State var promoItem: PromoItem
    @State var alertIsPresented: Bool = false
    
    var body: some View {
        VStack(spacing: 10) {
            if let imageName = promoItem.backgroundImageName,
                imageName.hasPrefix("http"),
                let url = URL(string: imageName) {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }   
            } else if let imageName = promoItem.backgroundImageName?.stripFileExtension() {
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
            
            /*
             For this assessment an alert is displayed upon button click displaying the
             target.
             */
            ForEach(promoItem.content ?? [], id: \.self) { item in
                Button {
                    alertIsPresented = true
                } label: {
                    Text(item.title)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .font(.system(size: 15))
                }
                .buttonStyle(.plain)
                .border(.gray)
                .padding([.leading, .trailing])
                .alert("Not Navigating To", isPresented: $alertIsPresented) {
                    
                } message: {
                    Text(item.target)
                }
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

//
//  PromoCardView.swift
//  ANF Code Test
//
//  Created by Chris Jarvi on 1/13/23.
//

import SwiftUI

struct PromoCardView: View {
    var body: some View {
        VStack(spacing: 10) {
            Image("anf-US-20160518-app-men-tees")
                .resizable()
                .scaledToFit()
            Text("A & F Essentials")
                .textCase(.uppercase)
            Text("Tops Starting at $12")
                .font(.system(size: 17, weight: .bold))
                .textCase(.uppercase)
            Text("Use Code: 12345")
                .font(.system(size: 11))
            HStack(spacing: 0) {
                Text("* In stores & online. ")
                Text("Exclusions apply. See Details")
                    .underline()
            }
            VStack {
                Button(action: {}) {
                    Text("Shop Men")
                        .padding()
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.plain)
                .border(.gray)
                Button(action: {}) {
                    Text("Shop Women")
                        .padding()
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.plain)
                .border(.gray)
            }
            .font(.system(size: 15))
            .padding([.leading, .trailing])
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

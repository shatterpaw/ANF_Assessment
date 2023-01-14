//
//  PromoItem.swift
//  ANF Code Test
//
//  Created by Chris Jarvi on 1/13/23.
//

import Foundation

struct PromoItem: Codable, Hashable {
    let title: String?
    let backgroundImageName: String?
    let promoMessage: String?
    let topDescription: String?
    let bottomDescription: String?
    let content: [ContentItem]?
    
    enum CodingKeys: String, CodingKey {
        case title
        case backgroundImageName = "backgroundImage"
        case topDescription
        case promoMessage
        case bottomDescription
        case content
    }
}

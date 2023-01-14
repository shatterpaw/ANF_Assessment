//
//  ContentItem.swift
//  ANF Code Test
//
//  Created by Chris Jarvi on 1/13/23.
//

import Foundation

struct ContentItem: Codable, Hashable {
    let elementType: String?
    let target: String
    let title: String
}

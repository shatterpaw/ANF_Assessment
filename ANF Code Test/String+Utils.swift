//
//  String+Utils.swift
//  ANF Code Test
//
//  Created by Chris Jarvi on 1/13/23.
//

import UIKit

extension String {
    func stripFileExtension() -> String {
        let components = self.components(separatedBy: ".")
        guard components.count > 1 else { return self }
        return components.dropLast(1).joined(separator: ".")
    }
}

extension StringProtocol {
    // modified from https://stackoverflow.com/a/70828186
    @MainActor
    func htmlToAttributedString(font: UIFont) throws -> AttributedString {
        let parsed = try NSAttributedString(data: .init(utf8),
                                            options: [
                                                .documentType: NSAttributedString.DocumentType.html,
                                                .characterEncoding: String.Encoding.utf8.rawValue
                                            ],
                                            documentAttributes: nil)
        
        var attributedString = AttributedString(parsed)
        attributedString.font = font
        return attributedString
    }
}

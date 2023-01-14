//
//  String+UtilsTests.swift
//  ANF Code TestTests
//
//  Created by Chris Jarvi on 1/13/23.
//

import ANF_Code_Test
import XCTest

final class String_UtilsTests: XCTestCase {

    func testStripFileExtension() throws {
        let testString = "someimage.jpg"
        let result = testString.stripFileExtension()
        XCTAssertEqual("someimage", result)
    }

    func testStripFileExtensionMultiplePeriods() throws {
        let testString = "some.image.jpg"
        let result = testString.stripFileExtension()
        XCTAssertEqual("some.image", result)
    }
    
    func testStripFileExtensionNoExtension() throws {
        let testString = "someimage"
        let result = testString.stripFileExtension()
        XCTAssertEqual("someimage", result)
    }
    
    @MainActor func testParseHTMLToAttributedString() throws {
        let testString = "*In stores & online. <a href=\\\"http://www.abercrombie.com/anf/media/legalText/viewDetailsText20160602_Tier_Promo_US.html\\\">Exclusions apply. See Details</a>"
        
        let result = try testString.htmlToAttributedString(font: .systemFont(ofSize: 13))
        let expected = "*In stores & online. Exclusions apply. See Details"
        XCTAssertTrue(result.characters.elementsEqual(expected))
    }
}


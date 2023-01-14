//
//  ANFExploreCardViewModelTests.swift
//  ANF Code TestTests
//
//  Created by Chris Jarvi on 1/14/23.
//

@testable import ANF_Code_Test
import XCTest

final class ANFExploreCardViewModelTests: XCTestCase {
    
    var viewModel: ANFExploreCardTableViewController.ANFExploreCardViewModel!

    override func setUpWithError() throws {
        try super.setUpWithError()
        
        viewModel = ANFExploreCardTableViewController.ANFExploreCardViewModel()
        viewModel.loadData(useLocal: true)
    }

    override func tearDownWithError() throws {
        viewModel = nil
        
        try super.tearDownWithError()
    }

    func testLoadData_ShouldHave10Items() throws {
        XCTAssertEqual(viewModel.exploreData?.count ?? 0, 10)
    }
    
    func testTshirtDresses_shouldHave1ContentItem() throws {
        let testItem = try XCTUnwrap(findTestItem(title: "T-SHIRT DRESSES"))
        XCTAssertEqual(testItem.content?.count, 1)
    }
    
    func testFashionTops_shouldHaveNoContentItems() throws {
        let testItem = try XCTUnwrap(findTestItem(title:"FASHION TOPS"))
        XCTAssertNil(testItem.content)
    }
    
    // MARK: Helpers
    func findTestItem(title: String) -> PromoItem? {
        viewModel.exploreData?.first(where: { $0.title == title })
    }
}

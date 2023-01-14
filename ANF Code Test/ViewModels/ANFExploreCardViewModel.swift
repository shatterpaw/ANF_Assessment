//
//  ANFExploreCardViewModel.swift
//  ANF Code Test
//
//  Created by Chris Jarvi on 1/14/23.
//

import UIKit

protocol DataUpdateDelegate: AnyObject {
    func dataDidUpdate()
}

extension ANFExploreCardTableViewController {
    class ANFExploreCardViewModel {
        var delegate: DataUpdateDelegate?
        var exploreData: [PromoItem]? {
            didSet { delegate?.dataDidUpdate() }
        }
        
        func loadData(useLocal: Bool = false) {
            if exploreData != nil { return }
            if useLocal {
                loadLocalData()
                return
            }
            Task {
                try? await loadCloudData()
            }
        }
        
        func loadImage(url: URL, _ closure: @escaping (UIImage?) -> Void) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        closure(image)
                    }
                }
            }
        }
        
        private func loadLocalData() {
            if let filePath = Bundle.main.path(forResource: "exploreData", ofType: "json"),
               let fileContent = try? Data(contentsOf: URL(fileURLWithPath: filePath)),
               let items = try? decodeJson(fileContent) {
                exploreData = items
            }
        }
        
        private func loadCloudData() async throws {
            guard let url = URL(string: "https://www.abercrombie.com/anf/nativeapp/qa/codetest/codeTest_exploreData.json") else {
                fatalError("Invalid URL")
            }
            
            let (data, _) = try await URLSession.shared.data(from: url)
            exploreData = try decodeJson(data)
        }
        
        private func decodeJson(_ data: Data) throws -> [PromoItem]? {
            return try JSONDecoder().decode([PromoItem].self, from: data)
        }
    }
}

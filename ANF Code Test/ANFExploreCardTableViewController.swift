//
//  ANFExploreCardTableViewController.swift
//  ANF Code Test
//

import UIKit
import SwiftUI

class ANFExploreCardTableViewController: UITableViewController, DataUpdateDelegate {

    var viewModel: ANFExploreCardViewModel = ANFExploreCardViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.loadData(useLocal: false)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.exploreData?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "ExploreContentCell", for: indexPath)

        guard let item = viewModel.exploreData?[indexPath.row] else {
            return cell
        }
        
        if let titleLabel = cell.viewWithTag(1) as? UILabel {
            titleLabel.text = item.title
        }
        
        if let imageView = cell.viewWithTag(2) as? UIImageView, let imageName = item.backgroundImageName {
            if imageName.hasPrefix("http"), let url = URL(string: imageName) {
                viewModel.loadImage(url: url) { image in
                    imageView.image = image
                }
            } else {
                let image = UIImage(named: imageName)
                imageView.image = image
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let promoItem = viewModel.exploreData?[indexPath.row] else { return }
        let promoCardView = PromoCardView(promoItem: promoItem)
        let hostController = UIHostingController(rootView: promoCardView)
        navigationController?.pushViewController(hostController, animated: true)
    }
    
    func dataDidUpdate() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
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

protocol DataUpdateDelegate: AnyObject {
    func dataDidUpdate()
}

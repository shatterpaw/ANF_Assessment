//
//  ANFExploreCardTableViewController.swift
//  ANF Code Test
//

import UIKit
import SwiftUI

class ANFExploreCardTableViewController: UITableViewController {

//    private var exploreData: [[AnyHashable: Any]]? {
//        if let filePath = Bundle.main.path(forResource: "exploreData", ofType: "json"),
//         let fileContent = try? Data(contentsOf: URL(fileURLWithPath: filePath)),
//         let jsonDictionary = try? JSONSerialization.jsonObject(with: fileContent, options: .mutableContainers) as? [[AnyHashable: Any]] {
//            return jsonDictionary
//        }
//        return nil
//    }
    private var exploreData: [PromoItem]? {
        if let filePath = Bundle.main.path(forResource: "exploreData", ofType: "json"),
           let fileContent = try? Data(contentsOf: URL(fileURLWithPath: filePath)),
           let items = try? JSONDecoder().decode([PromoItem].self, from: fileContent) {
            return items
        }
        return nil
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        exploreData?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "ExploreContentCell", for: indexPath)

        guard let item = exploreData?[indexPath.row] else {
            return cell
        }
        
        if let titleLabel = cell.viewWithTag(1) as? UILabel {
            titleLabel.text = item.title
        }
        
        if let imageView = cell.viewWithTag(2) as? UIImageView,
           let name = item.backgroundImageName,
           let image = UIImage(named: name) {
            imageView.image = image
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let promoCardView = PromoCardView()
        let hostController = UIHostingController(rootView: promoCardView)
        navigationController?.pushViewController(hostController, animated: true)
    }
}

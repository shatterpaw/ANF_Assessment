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
                imageView.image = UIImage(named: imageName)
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

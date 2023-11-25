//
//  FavController.swift
//  nomnom
//
//  Created by Jack on 11/9/23.
//

import UIKit

class FavController: UITableViewController {
    
    var favorites = [BusinessCardModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateBadgeValue()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveFavoritesUpdate), name: Notification.Name("FavoritesUpdated"), object: nil)
        
        tableView.keyboardDismissMode = .interactive
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
		
        favorites = BusinessCardModel.getFood(forKey: BusinessCardModel.favoritesKey)
        tableView.reloadData()
    }

    // Handle the notification
    @objc private func didReceiveFavoritesUpdate() {
        updateBadgeValue()
    }

    func updateBadgeValue() {
        let cardIDArray = BusinessCardModel.getFood(forKey: "Favorites")
        tabBarItem.badgeValue = String(cardIDArray.count)
    }

    deinit {
        // Remove the observer in deinit to prevent memory leaks
        NotificationCenter.default.removeObserver(self, name: Notification.Name("FavoritesUpdated"), object: nil)
    }
}

// MARK: - UITableViewDataSource and UITableViewDelegate
extension FavController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        
        // Configure the default cell here
        cell.textLabel?.text = favorites[indexPath.row].name
        // Add other configurations if needed
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("We are here \(indexPath)")
        
        let expandedVC = ExpandFeatureController()
        expandedVC.card = favorites[indexPath.row]
        navigationController?.pushViewController(expandedVC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (view.frame.height / 10) 
    }
}

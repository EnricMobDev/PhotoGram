//
//  MenuViewController.swift
//  PhotoGram
//
//  Created by Enric Pou Villanueva on 14/8/18.
//  Copyright © 2018 Enric Pou Villanueva. All rights reserved.
//

import UIKit

enum TypeOfMenu {
    
    case profile, notifications, settings, logout
}

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //MARK: - Constants
    let createCells: [DrawerItemProtocol] = [
        
        OptionsMenu(image: UIImage(named: "profile_image_male") ?? UIImage(), title: "Profile", typeOfMenu: .profile),
        OptionsMenu(image: UIImage(named: "ic_alerts") ?? UIImage(), title: "Notifications", typeOfMenu: .notifications),
        OptionsMenu(image: UIImage(named: "settings") ?? UIImage(), title: "Settings", typeOfMenu: .settings),
        OptionsMenu(image: UIImage(named: "ic_apagar_black") ?? UIImage(), title: "Logout", typeOfMenu: .logout)
    ]
    
    // MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Private methods
    private func showView(named: String) {
        
        performSegue(withIdentifier: named, sender: self)

    }
    
    // MARK: - Creation of table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return createCells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = createCells[indexPath.row]
        let drawer = item.cellDrawer
        
        let cell = drawer.tableView(tableView, cellForRowAt: indexPath)
        drawer.drawCell(cell, withItem: item)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let cell = createCells[indexPath.row] as? OptionsMenu {
            
            switch cell.typeOfMenu {
                
            case .profile:
                
                showView(named: "goToProfileSegue")
                
            case .notifications:
                
                showView(named: "goToNotificationsSegue")

            case .settings:
                
                showView(named: "goToSettingsSegue")

            case .logout:
                
                dismiss(animated: true, completion: nil)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = CellComponents.estimatedRowHeigth
        return tableView.rowHeight
    }
}

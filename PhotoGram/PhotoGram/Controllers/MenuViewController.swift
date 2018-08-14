//
//  MenuViewController.swift
//  PhotoGram
//
//  Created by Enric Pou Villanueva on 14/8/18.
//  Copyright © 2018 Enric Pou Villanueva. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //MARK: - Constants
    let createCells: [DrawerItemProtocol] = [
        
        OptionsMenu(image: UIImage(named: "profile_image_male") ?? UIImage(), title: "Logout"),
        OptionsMenu(image: UIImage(named: "logout") ?? UIImage(), title: "Logout")
    ]
    
    // MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
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
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = CellComponents.estimatedRowHeigth
        return tableView.rowHeight
    }
}

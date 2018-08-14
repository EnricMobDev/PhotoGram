//
//  MenuCellDrawer.swift
//  PhotoGram
//
//  Created by Enric Pou Villanueva on 14/8/18.
//  Copyright © 2018 Enric Pou Villanueva. All rights reserved.
//

import Foundation
import UIKit

internal final class MenuCellDrawer: CellDrawerProtocol {
    
    // MARK: - Constants
    private struct Constants {
        static let reuseID = "MenuCell"
    }
    
    // MARK: - CellDrawerProtocol
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return tableView.dequeueReusableCell(withIdentifier: Constants.reuseID,
                                             for: indexPath)
    }
    
    func drawCell(_ cell: UITableViewCell, withItem item: Any) {
        
        guard let cell = cell as? MenuTableViewCell,
            let item = item as? OptionsMenu else {
                return
        }
        
        cell.selectionStyle = .none
        cell.menuImage.layer.cornerRadius = 10
        cell.menuImage.image = item.image
        cell.menuTitle.text = item.title
    }
}

// MARK: - OptionsMenu + DrawerItem
extension OptionsMenu: DrawerItemProtocol {
    
    var cellDrawer: CellDrawerProtocol {
        
        return MenuCellDrawer()
    }
}

//
//  CellDrawerProtocol.swift
//  PhotoGram
//
//  Created by Enric Pou Villanueva on 14/8/18.
//  Copyright © 2018 Enric Pou Villanueva. All rights reserved.
//

import UIKit

internal protocol CellDrawerProtocol {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    
    func drawCell(_ cell: UITableViewCell, withItem item: Any)
}

//
//  FeedViewController.swift
//  PhotoGram
//
//  Created by Enric Pou Villanueva on 14/8/18.
//  Copyright © 2018 Enric Pou Villanueva. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {

    // MARK: - IBActions
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if self.revealViewController() != nil {
            
            self.menuButton.target = self.revealViewController()
            self.menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
}

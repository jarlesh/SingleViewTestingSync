//
//  ViewController.swift
//  SingleViewTestingSync
//
//  Created by Jarle Heldstab on 19/01/2018.
//  Copyright © 2018 Jarle Heldstab. All rights reserved.
//

import Cocoa
import CloudKit

class ViewController: NSViewController {
    
    let playerDataSource = PlayerDataSource.sharedInstance

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    func tryGettingDataFromCloud() {
        
    }


}


//
//  TrainerSource.swift
//  SingleViewTesting
//
//  Created by Jarle Heldstab on 04/12/2017.
//  Copyright © 2017 Jarle Heldstab. All rights reserved.
//

import Foundation

class TrainerDataSource
{
    
    // MARK: Static data variables
    static let sharedInstance = TrainerDataSource()
    
    private init()
    {
        print("Private init of Singleton")
    }
}

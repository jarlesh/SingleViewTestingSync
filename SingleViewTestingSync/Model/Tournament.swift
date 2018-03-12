//
//  Tournament.swift
//  SingleViewTestingSync
//
//  Created by Jarle Heldstab on 02/03/2018.
//  Copyright © 2018 Jarle Heldstab. All rights reserved.
//

import CloudKit
import Foundation

class Tournament {
    
    private (set) var name: String
    private (set) var matches: [Match]
    private (set) var cloudKitRecord: CKRecord
    
    init(name: String) {
        self.name = name
        self.cloudKitRecord = CKRecord(recordType: "Tournament")
        cloudKitRecord.setObject(self.name as CKRecordValue, forKey: "name")
        self.matches = [Match]()
    }
    
    public func add(_ match: Match) {
        self.matches.append(match)
    }
    
    public func getMatches() {
        
    }
}

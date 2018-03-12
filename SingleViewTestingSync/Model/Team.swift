//
//  Team.swift
//  SingleViewTesting
//
//  Created by Jarle Heldstab on 19/10/2016.
//  Copyright © 2016 Jarle Heldstab. All rights reserved.
//

import CloudKit
import Foundation

class Team {
    
    // MARK: Properties
    var name: String
    private (set) var cloudKitRecord: CKRecord
    
    private (set) var tournament: Tournament?
    
    var shortName: String?
    var image: String?
    
    var location: Location?
    var trainer1: Trainer?
    var trainer2: Trainer?
    

    struct Location {
        var googleMapsAddress: String
        var description: String
    }
    
    // MARK: Initialization
    init(name: String) {
        self.name = name
        self.cloudKitRecord = CKRecord(recordType: "Team")
        self.cloudKitRecord.setObject(name as CKRecordValue, forKey: "name")
    }
    
    convenience init(withPropertiesFrom: CKRecord) {
        self.init(name: withPropertiesFrom.object(forKey: "Name") as! String,
                  shortName: withPropertiesFrom.object(forKey: "ShortName") as! String,
                  image: withPropertiesFrom.object(forKey: "Image") as! String,
                  trainerA: withPropertiesFrom.object(forKey: "TrainerA") as! Trainer,
                  trainerB: withPropertiesFrom.object(forKey: "TrainerB") as! Trainer,
                  locationGoogleMaps: withPropertiesFrom.object(forKey: "LocationGoogleMapAddress") as! String,
                  locationDescription: withPropertiesFrom.object(forKey: "LocationDescription") as! String
        )
    }
}

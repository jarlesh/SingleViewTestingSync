//
//  Match.swift
//  SingleViewTesting
//
//  Created by Jarle Heldstab on 15/10/2016.
//  Copyright © 2016 Jarle Heldstab. All rights reserved.
//

import CloudKit
import Foundation


struct Location {
    var googleMapAddress: String
    var description: String
}

class Match {

    // MARK: Properties
    var dateTime: Date
    var teamA: Team
    var teamB: Team
    private (set) var cloudKitRecord: CKRecord
    private (set) var tournament: Tournament?

    enum State {
        case played
        case changed
        case confirmed
        case initialized
    }
    
    // MARK: Initialization
    init(teamA: Team, teamB: Team, dateTime: Date, tournament: Tournament) {
        self.dateTime = dateTime
        self.teamA = teamA
        self.teamB = teamB
        self.tournament = tournament
        self.cloudKitRecord = CKRecord(recordType: "Match")
        self.cloudKitRecord.setObject(dateTime as CKRecordValue, forKey: "time")
        self.cloudKitRecord.setObject(CKReference(recordID: teamA.cloudKitRecord.recordID, action: .none), forKey: "teamA")
        self.cloudKitRecord.setObject(CKReference(recordID: teamB.cloudKitRecord.recordID, action: .none), forKey: "teamB")
    }
}

//
//  RecordType.swift
//  SingleViewTesting
//
//  Created by Jarle Heldstab on 16/12/2017.
//  Copyright © 2017 Jarle Heldstab. All rights reserved.
//

import CloudKit
import Foundation

struct CloudKitDataSource {
    
    enum RecordType: String {
        case guardian = "Guardian"
        case match = "Match"
        case person = "Person"
        case player = "Player"
        case team = "Team"
    }
    
    
    // MARK: Static data variables
    static let sharedInstance = CloudKitDataSource()
    let mood = "😃"
    
    private init()
    {
        print("Private init of Singleton")
    }
    
    public func createCloudKitRecordTypeFrom(_ player: Player) -> CKRecord {
        let cloudKitPlayer = CKRecord(recordType: RecordType.player.rawValue)
        cloudKitPlayer.setObject(player.firstName as CKRecordValue, forKey: "FirstName");
        cloudKitPlayer.setObject(player.lastName as CKRecordValue, forKey: "LastName");
        cloudKitPlayer.setObject(player.teamReference as CKRecordValue, forKey: "teamNumber");
        cloudKitPlayer.setObject(1 as CKRecordValue, forKey: "Active")
        return cloudKitPlayer
    }
    
    public func createReference(guardian1: CKRecord, and guardian2: CKRecord, for player: CKRecord) {
        let guardianReference1 = CKReference(recordID: guardian1.recordID, action: .none)
        let guardianReference2 = CKReference(recordID: guardian2.recordID, action: .none)
        
        player.setObject(guardianReference1, forKey: "Guardian1")
        player.setObject(guardianReference2, forKey: "Guardian2")
    }
    
    public func createCloudKitRecordTypeFrom(_ guardian: Guardian) -> CKRecord {
        let cloudKitGuardian = CKRecord(recordType: RecordType.guardian.rawValue)
        cloudKitGuardian.setObject(guardian.firstName as CKRecordValue, forKey: "FirstName")
        cloudKitGuardian.setObject(guardian.lastName as CKRecordValue, forKey: "LastName")
        cloudKitGuardian.setObject(guardian.email! as CKRecordValue, forKey: "Email")
        cloudKitGuardian.setObject((guardian.phone! as CKRecordValue), forKey: "Phone")
        cloudKitGuardian.setObject("Address" as CKRecordValue, forKey: "Address")
        return cloudKitGuardian
    }
    
    public func createCloudKitRecordTypeFrom(_ team: Team) -> CKRecord {
        let ckRecord = CKRecord(recordType: "Team")
        print("ja konverterer")
        ckRecord.setObject(team.name as CKRecordValue, forKey: "teamName")
        return ckRecord
    }
    
    public func createCloudKitRecordTypeFrom(_ tournament: Tournament) -> CKRecord {
        let ckRecord = CKRecord(recordType: "Torunament")
        ckRecord.setObject(tournament.name as CKRecordValue, forKey: "tournamentName")
        return ckRecord
    }
    
    public func createCloudKitRecordTypeFrom(_ match: Match) -> CKRecord {
        let ckRecord = CKRecord(recordType: "Match")
        ckRecord.setObject(match.dateTime as CKRecordValue, forKey: "matchDateAndTime")
        // ckRecord.setObject(match.teamA as CKRecordValue, forKey: "matchTeamA")
        // ckRecord.setObject(match.teamB as CKRecordValue, forKey: "matchTeamB")
        return ckRecord
    }
    
}

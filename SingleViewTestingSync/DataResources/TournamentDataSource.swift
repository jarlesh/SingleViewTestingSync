//
//  TournamentDataSource.swift
//  SingleViewTestingSync
//
//  Created by Jarle Heldstab on 03/03/2018.
//  Copyright © 2018 Jarle Heldstab. All rights reserved.
//

import CloudKit
import Foundation

class TournamentDataSource
{
    // MARK: Static data variables
    public let fileDataSource = FileReaderDataSource.sharedInstance
    public private(set) var tournaments = [Tournament]()
    private var cloudKitRecords = [CKRecord]()
    private let cloudKitLoadTaskQueue = DispatchGroup()
    private let cloudKitSaveTaskQueue = DispatchGroup()
    
    //    private let cloudKitDatabase = CKContainer.default().publicCloudDatabase
    private let cloudKitDatabase = CKContainer(identifier: "iCloud.com.example.SingleViewTesting").publicCloudDatabase
    
    // MARK: Static data variables
    static let sharedInstance = TournamentDataSource()
    private let ckRecordInstance = CloudKitDataSource.sharedInstance
    
    private init()
    {
        print("Private init of Singleton")
    }
    
    public func loadDataFromCloudKit() {
//        let tournamentsFromCloudKit = self.loadTournamentsFromCloudKit()
//        self.tournaments.append(contentsOf: tournamentsFromCloudKit)
    }
    
    public func loadDataFromFile() {
        let tournamentsFromFile = self.loadTournamentsFromFile()
        self.tournaments.append(contentsOf: tournamentsFromFile)
        // self.save(tournaments: self.tournaments)
    }
    
    private func loadTournamentsFromFile() -> [Tournament] {

        var tournaments = [Tournament]()
        var tournamentsFromFile = [String]()
        tournamentsFromFile = fileDataSource.readCommaSeperatedContent(in: "turneringer")
        
        if tournamentsFromFile.count > 0 {
            for tournament in tournamentsFromFile {
                let columnValues = tournament.components(separatedBy: ";")
                let tournament = Tournament(name: columnValues[0])
                tournaments.append(tournament)
            }
        }
        return tournaments
    }
    
//    private func loadTournamentsFromCloudKit() -> [Tournament] {
//        return Tournament(name: "Ukjent")
//    }
    
    public func getTorunament(withName searchedName: String) -> Tournament? {
        for tournament in self.tournaments {
            if (tournament.name == searchedName) {
                return tournament
            }
        }
        return nil
    }
    
    public func save(tournament: Tournament) {

    }
    
    public func save(tournaments: [Tournament]) {
        let operation = CKModifyRecordsOperation(
            recordsToSave: tournaments.map { ckRecordInstance.createCloudKitRecordTypeFrom($0) },
            recordIDsToDelete: nil
        )
        // operation.perRecordProgressBlock = { print("Tournament progress \($1)") } 
        // operation.savePolicy = .allKeys
        cloudKitDatabase.add(operation)
    }
    
    public func syncTeamsToCloudKit() {

    }
    
    public func append(contentsOf: [Tournament]) {

    }
    
    public func deleteCloudKitData() {

    }
}

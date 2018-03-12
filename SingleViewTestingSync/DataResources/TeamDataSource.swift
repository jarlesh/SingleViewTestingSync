//
//  TeamDataSource.swift
//  SingleViewTesting
//
//  Created by Jarle Heldstab on 04/12/2017.
//  Copyright © 2017 Jarle Heldstab. All rights reserved.
//  Link info https://littlebitesofcocoa.com/topics/36-cloudkit

import CloudKit
import Foundation

class TeamDataSource
{
    // MARK: Static data variables
    public let fileDataSource = FileReaderDataSource.sharedInstance
    public private(set) var teams = [Team]()
    private var cloudKitRecords = [CKRecord]()
    private let cloudKitLoadTaskQueue = DispatchGroup()
    private let cloudKitSaveTaskQueue = DispatchGroup()
    
    //    private let cloudKitDatabase = CKContainer.default().publicCloudDatabase
    private let cloudKitDatabase = CKContainer(identifier: "iCloud.com.example.SingleViewTesting").publicCloudDatabase
    
    // MARK: Static data variables
    static let sharedInstance = TeamDataSource()
    private let ckRecordInstance = CloudKitDataSource.sharedInstance
    
    private init()
    {
        print("Private init of Singleton")
    }
    
    public func loadDataFromCloudKit() {
//        let teamsFromCloudKit = self.loadTeamsFromCloudKit()
//        self.teams.append(contentsOf: teamsFromCloudKit)
    }
    
    public func loadDataFromFile() {
        let teamsFromFile = self.loadTeamsFromFile()
        self.teams.append(contentsOf: teamsFromFile)
        print("teams.count \(teams.count)")
        // self.save(teams: self.teams)
    }
    
    private func loadTeamsFromFile() -> [Team] {
        var teams = [Team]()
        var teamsFromFile = [String]()
        
        teamsFromFile = fileDataSource.readCommaSeperatedContent(in: "lag")
        
        if teamsFromFile.count > 0 {
            for team in teamsFromFile {
                let columnValues = team.components(separatedBy: ";")
                let team = Team(name: columnValues[0], tournament: columnValues[1])
                print("Team added: \(team.name)")
                teams.append(team)
            }
        }
        return teams
    }
    
//    private func loadTeamsFromCloudKit() -> [Team] {
//
//    }
    
    public func getTeam(withName searchedName: String, inTournament: String) -> Team? {
        for team in self.teams {
            print("Looking for \(searchedName) in \(inTournament), this is \(team.name) in \(team.tournament!)")
            if (team.name == searchedName && team.tournament == inTournament) {
                return team
            }
        }
        return nil
    }
    
    public func save(team: Team) {
        
    }
    
    public func save(teams: [Team]) {
        var test = [Team]()
        test.append(teams[3])
        let operation = CKModifyRecordsOperation(
            recordsToSave: test.map { ckRecordInstance.createCloudKitRecordTypeFrom($0) },
            recordIDsToDelete: nil
        )
        // operation.perRecordProgressBlock = { print("My team") }
        // operation.savePolicy = .allKeys

        cloudKitDatabase.add(operation)
        operation.modifyRecordsCompletionBlock = { added, deleted, error in
            if error != nil {
                print(error)
            } else {
                print("Deleted records")
            }
        }
    }
    
    public func syncTeamsToCloudKit() {

    }
    
    public func append(_ guardian: Guardian, to Team: Team) {

    }
    
    public func deleteCloudKitData() {

    }
}

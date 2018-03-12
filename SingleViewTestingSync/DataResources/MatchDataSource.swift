//
//  MatchSource.swift
//  SingleViewTesting
//
//  Created by Jarle Heldstab on 04/12/2017.
//  Copyright © 2017 Jarle Heldstab. All rights reserved.
//

import CloudKit
import Foundation

class MatchDataSource
{
    // MARK: Static data variables
    public let fileDataSource = FileReaderDataSource.sharedInstance
    public private(set) var matches = [Match]()
    private var cloudKitRecords = [CKRecord]()
    private let cloudKitLoadTaskQueue = DispatchGroup()
    private let cloudKitSaveTaskQueue = DispatchGroup()
    
    //    private let cloudKitDatabase = CKContainer.default().publicCloudDatabase
    private let cloudKitDatabase = CKContainer(identifier: "iCloud.com.example.SingleViewTesting").publicCloudDatabase
    
    // MARK: Static data variables
    static let sharedInstance = MatchDataSource()
    private let ckRecordInstance = CloudKitDataSource.sharedInstance
    
    private init()
    {
        print("Private init of Singleton")
    }

    public func loadDataFromCloudKit() {
        //        let matchesFromCloudKit = self.loadmatchesFromCloudKit()
        //        self.matches.append(contentsOf: matchesFromCloudKit)
        
    }
    
    public func loadDataFromFile() {
        let matchesFromFile = self.loadMatchesFromFile()
        self.matches.append(contentsOf: matchesFromFile)
        self.save(matches: self.matches)
    }
    
    private func loadMatchesFromFile() -> [Match] {
        var matches = [Match]()
        var matchesFromFile = [String]()
        
        matchesFromFile = fileDataSource.readCommaSeperatedContent(in: "kamper")
        
        if matchesFromFile.count > 0 {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yyyy HH:mm"
            // dateFormatter.locale = Locale(identifier: "en_US_POSIX")
//            do {
//                
//            }
//            catch machineError.invalidSelection {
//                print("Invalid Selection.")
//            }
            for match in matchesFromFile {
                let columnValues = match.components(separatedBy: ";")
                let stringDate = "\(columnValues[1]) \(columnValues[3])"
                let date = dateFormatter.date(from: stringDate)
                let match = Match(teamA: TeamDataSource.sharedInstance.getTeam(withName: columnValues[4], inTournament: columnValues[8])!,
                                  teamB: TeamDataSource.sharedInstance.getTeam(withName: columnValues[6], inTournament: columnValues[8])!,
                                  dateTime: date!,
                                  tournament: TournamentDataSource.sharedInstance.getTorunament(withName: columnValues[8])!
                )
                matches.append(match)
                if (matches.count > 9) {
                    return matches
                }
            }
        }
        return matches
    }
    
    //    private func loadmatchesFromCloudKit() -> [Match] {
    //
    //    }
    
    public func save(match: Match) {
        
    }
    
    public func save(matches: [Match]) {

        let operation = CKModifyRecordsOperation(
            recordsToSave: matches.map { ckRecordInstance.createCloudKitRecordTypeFrom($0) },
            recordIDsToDelete: nil
        )
        // operation.perRecordProgressBlock = { print("My team") }
        // operation.savePolicy = .allKeys
        
        cloudKitDatabase.add(operation)
        
//        operation.modifyRecordsCompletionBlock = { added, deleted, error in
//            if error != nil {
//                print(error)
//            } else {
//                print("Deleted records")
//            }
//        }
    }
    
    public func syncMatchesToCloudKit() {
        
    }

    public func deleteCloudKitData() {
        
    }
    

}

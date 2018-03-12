////
////  PlayerSource.swift
////  SingleViewTesting
////
////  Created by Jarle Heldstab on 04/12/2017.
////  Copyright © 2017 Jarle Heldstab. All rights reserved.
////
//
//import CloudKit
//import Foundation
//
//protocol PlayerDataSourceHandler {
//
//    var playerDataSource: PlayerDataSource { get }
//    func getPlayers() -> [Player]
//    func save(player: Player)
//    func delete(player: Player)
//}
//
//class PlayerDataSource
//{
//
//    // MARK: Static data variables
//    static let sharedInstance = PlayerDataSource()
//    public let fileDataSource = FileReaderDataSource.sharedInstance
//    public private(set) var players = [Player]()
//    private var cloudKitRecords = [CKRecord]()
//    private let cloudKitLoadTaskQueue = DispatchGroup()
//    private let cloudKitSaveTaskQueue = DispatchGroup()
//
////    private let cloudKitDatabase = CKContainer.default().publicCloudDatabase
//    private let cloudKitDatabase = CKContainer(identifier: "iCloud.com.example.SingleViewTesting").publicCloudDatabase
//
//    private init() {
//        print("PlayerDataSource init")
//        // let playersFromFile = loadPlayersFromFile()
//        // let playersFromCloudKit = loadPlayersFromCloudKit()
//
//        // self.players.append(contentsOf: playersFromFile)
//        // self.players.append(contentsOf: playersFromCloudKit)
//        // check if they are the same, otherwise, update cloudkit
//    }
//
//
//
//    public func loadDataFromCloudKit() {
//        let playersFromCloudKit = self.loadPlayersFromCloudKit()
//        self.players.append(contentsOf: playersFromCloudKit)
//    }
//
//    public func loadDataFromFile() {
//        let playersFromFile = self.loadPlayersFromFile()
//        self.players.append(contentsOf: playersFromFile)
//    }
//
//    private func loadPlayersFromFile() -> [Player] {
//        // Do something here@
//        var players = [Player]()
//        var tempResult = [String]()
//
//        tempResult = fileDataSource.readCommaSeperatedContent(in: "spillere")
//        tempResult = fileDataSource.removeCommaSeperatedContent(in: tempResult, where: tempResult, doesNotContain: "/09")
//
//        if tempResult.count > 0 {
//            for string in tempResult {
//                let properties = string.components(separatedBy: ";")
//                let guardian1 = Guardian(firstName: "File1",
//                                         lastName: "File",
//                                         email: properties[4],
//                                         phone: properties[7],
//                                         address: properties[6])
//                let guardian2 = Guardian(firstName: "File2",
//                                         lastName: "File",
//                                         email: properties[5],
//                                         phone: properties[8],
//                                         address: properties[6])
//                let player = Player(teamReference: Int(properties[0])!,
//                                    firstName: properties[1],
//                                    lastName: properties[2],
//                                    guardian1: guardian1,
//                                    guardian2: guardian2)
//                players.append(player)
//            }
//        }
//        return players
//    }
//
//    private func loadPlayersFromCloudKit() -> [Player]
//    {
//        var playersFromCloudKit = [CKRecord]()
//        var players = [Player]()
//        self.cloudKitLoadTaskQueue.enter()
//
//        let cloudKitQuery = CKQuery(recordType: CloudKitDataSource.RecordType.player.rawValue, predicate: NSPredicate(format: "TRUEPREDICATE"))
//        let guardianSortDesc = NSSortDescriptor(key: "Number", ascending: true)
//
//        cloudKitQuery.sortDescriptors = [guardianSortDesc]
//
//        cloudKitDatabase.perform(cloudKitQuery, inZoneWith: nil, completionHandler: ({results, error in
//
//            if (error != nil)
//            {
//                print(error!.localizedDescription)
//            }
//            else
//            {
//                if results!.count > 0
//                {
//                    playersFromCloudKit = results!
//                    self.cloudKitRecords = results!
//                    print("Players loaded \(playersFromCloudKit.count)")
//                    for cloudKitRecord in playersFromCloudKit
//                    {
//                        let guardian1 = GuardianDataSource.sharedInstance.getGuardian(using: cloudKitRecord.object(forKey: "Guardian1") as! CKReference)
//                        let guardian2 = GuardianDataSource.sharedInstance.getGuardian(using: cloudKitRecord.object(forKey: "Guardian2") as! CKReference)
//
//                        players.append(
//                            Player(teamReference: cloudKitRecord.object(forKey: "teamNumber") as! Int,
//                                   firstName: cloudKitRecord.object(forKey: "FirstName") as! String,
//                                   lastName: cloudKitRecord.object(forKey: "LastName") as! String,
//                                   guardian1: guardian1!,
//                                   guardian2: guardian2!
//                            )
//                        )
//                    }
//                }
//                else
//                {
//                    print("Result query for \(cloudKitQuery.recordType) is empty")
//                }
//            }
//            self.cloudKitLoadTaskQueue.leave()
//        }))
//        print("Wait for players to load")
//        self.cloudKitLoadTaskQueue.wait()
//        print("Players finished loading")
//        // self.players = players
//        return players
//    }
//
//    public func save(player: Player)
//    {
//        let cloudKitPlayer = CloudKitDataSource.sharedInstance.createCloudKitRecordTypeFrom(player)
//        let cloudKitGuardian1 = CloudKitDataSource.sharedInstance.createCloudKitRecordTypeFrom(player.guardian1!)
//        let cloudKitGuardian2 = CloudKitDataSource.sharedInstance.createCloudKitRecordTypeFrom(player.guardian2!)
//
//        CloudKitDataSource.sharedInstance.createReference(guardian1: cloudKitGuardian1, and: cloudKitGuardian2, for: cloudKitPlayer)
//
//        cloudKitSaveTaskQueue.enter()
//        cloudKitDatabase.save(cloudKitPlayer) { (record, error) -> Void in
//            if error != nil
//            {
//                print(error)
//                return
//            }
//            else
//            {
//                print("Saved")
//                self.cloudKitSaveTaskQueue.leave()
//            }
//        }
////        self.players.append(player)
////
//        GuardianDataSource.sharedInstance.append(guardian: player.guardian1!, and: cloudKitGuardian1)
//        GuardianDataSource.sharedInstance.append(guardian: player.guardian2!, and: cloudKitGuardian2)
//    }
//
//    public func syncPlayersToCloudKit() {
//        // And need to check if already exist
//        // Will automatically append guardians
//        for player in self.players {
//            print("Syncing to iCloud: \(player.firstName)")
//            self.save(player: player)
//        }
//    }
//
//    public func append(_ guardian: Guardian, to player: Player)
//    {
//        // self.players.append(player)
//
//        let cloudKitPlayer = CKRecord(recordType: "Player")
//        cloudKitPlayer.setObject(player.firstName as CKRecordValue, forKey: "FirstName");
//        cloudKitPlayer.setObject(player.lastName as CKRecordValue, forKey: "LastName");
//        cloudKitPlayer.setObject(player.teamReference as CKRecordValue, forKey: "teamNumber");
//        // cloudKitPlayer.setObject(player.guardian1 as! CKRecordValue, forKey: "Guardian1");
//        // cloudKitPlayer.setObject(player.guardian2 as! CKRecordValue, forKey: "Guardian2");
//
//
//        cloudKitSaveTaskQueue.enter()
//        cloudKitDatabase.save(cloudKitPlayer) { (record, error) -> Void in
//            if error != nil {
//                return
//            }
//            else {
//                self.cloudKitSaveTaskQueue.leave()
//            }
//        }
//    }
//
//    public func deleteCloudKitData() {
//        var recordIDToDelete = [CKRecordID]()
//        for ckRecord in self.cloudKitRecords {
//            recordIDToDelete.append(ckRecord.recordID)
//        }
//        let operation = CKModifyRecordsOperation(recordsToSave: nil, recordIDsToDelete: recordIDToDelete)
//        operation.savePolicy = .allKeys
//        operation.modifyRecordsCompletionBlock = { added, deleted, error in
//            if error != nil {
//                print(error)
//            } else {
//                print("Deleted records")
//            }
//        }
//        cloudKitDatabase.add(operation)
//    }
//}
//

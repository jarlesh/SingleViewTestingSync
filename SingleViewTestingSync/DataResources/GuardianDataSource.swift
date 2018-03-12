//
//  GuardianSource.swift
//  SingleViewTesting
//
//  Created by Jarle Heldstab on 04/12/2017.
//  Copyright © 2017 Jarle Heldstab. All rights reserved.
//

import CloudKit
import Foundation

class GuardianDataSource
{
    
    // MARK: Static data variables
    static let sharedInstance = GuardianDataSource()
    public private(set) var guardians = [Guardian]()
    private var cloudKitRecords = [CKRecord]()
    private let cloudKitLoadTaskQueue = DispatchGroup()
    private let cloudKitSaveTaskQueue = DispatchGroup()
    
    //    private let cloudKitDatabase = CKContainer.default().publicCloudDatabase
    private let cloudKitDatabase = CKContainer(identifier: "iCloud.com.example.SingleViewTesting").publicCloudDatabase
    
    private init() {
        print("GuardianDataSource init")
        // var guardiansFromFile = loadGuardiansFromFile()
        // var guardiansFromCloudKit = loadGuardiansFromCloudKit()
        
    }
    
    public func loadDataFromCloudKit() {
        let guardiansFromCloudKit = self.loadGuardiansFromCloudKit()
        self.guardians.append(contentsOf: guardiansFromCloudKit)
    }

    public func loadDataFromFile() {
//        let guardiansFromFile = self.loadDataFromFile()
//        self.guardians.append(contentsOf: guardiansFromFile)
    }
    
    public func loadGuardiansFromCloudKit() -> [Guardian]
    {
        var guardiansFromCloudKit = [CKRecord]()
        var guardians = [Guardian]()
        self.cloudKitLoadTaskQueue.enter()
        let cloudKitQuery = CKQuery(recordType: "Guardian", predicate: NSPredicate(format: "TRUEPREDICATE"))
        let guardianSortDesc = NSSortDescriptor(key: "LastName", ascending: true)
        
        cloudKitQuery.sortDescriptors = [guardianSortDesc]
        
        cloudKitDatabase.perform(cloudKitQuery, inZoneWith: nil, completionHandler: ({results, error in
            
            if (error != nil)
            {
                print(error!.localizedDescription)
            }
            else
            {
                if results!.count > 0
                {
                    guardiansFromCloudKit = results!
                    self.cloudKitRecords = results!
                    print("Guardians loaded \(guardiansFromCloudKit.count)")
                    for cloudKitRecord in guardiansFromCloudKit
                    {
                        guardians.append(
                            Guardian(firstName: cloudKitRecord.object(forKey: "FirstName") as! String,
                                     lastName: cloudKitRecord.object(forKey: "LastName") as! String,
                                     email: cloudKitRecord.object(forKey: "Email") as! String,
                                     phone: cloudKitRecord.object(forKey: "Phone") as! String,
                                     address: "NotImplementedAddress")
                        )
                    }
                }
                else
                {
                    print("Result query for \(cloudKitQuery.recordType) is empty")
                }
            }
            self.cloudKitLoadTaskQueue.leave()
        }))
        print("Wait for guardians to load")
        self.cloudKitLoadTaskQueue.wait()
        print("Guardians finished loading")
        self.guardians = guardians
        return guardians
    }
    
    public func append(guardian: Guardian, and cloudKitGuardian: CKRecord)
    {
        self.guardians.append(guardian)
        
        cloudKitSaveTaskQueue.enter()
        cloudKitDatabase.save(cloudKitGuardian) { (record, error) -> Void in
            if error != nil
            {
                return
            }
            else
            {
                print("Guardian now saved")
                self.cloudKitSaveTaskQueue.leave()
            }
        }
    }
    
    public func deleteCloudKitData() {
        var recordIDToDelete = [CKRecordID]()
        for ckRecord in self.cloudKitRecords {
            recordIDToDelete.append(ckRecord.recordID)
        }
        let operation = CKModifyRecordsOperation(recordsToSave: nil, recordIDsToDelete: recordIDToDelete)
        operation.savePolicy = .allKeys
        operation.modifyRecordsCompletionBlock = { added, deleted, error in
            if error != nil {
                print(error)
            } else {
                print("Deleted records")
            }
        }
        cloudKitDatabase.add(operation)
    }
    
    public func getCloudKitRecord(using cloudKitReference: CKReference) -> CKRecord? {
        for cloudKitRecord in self.cloudKitRecords {
            if(cloudKitRecord.recordID == cloudKitReference.recordID) {
                return cloudKitRecord
            }
        }
        return nil
    }
    
    public func getGuardian(using cloudKitReference: CKReference) -> Guardian? {
        for number in 0...self.cloudKitRecords.count-1 {
            if(cloudKitRecords[number].recordID == cloudKitReference.recordID) {
                return guardians[number]
            }
        }
        return nil
    }
}

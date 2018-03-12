//
//  AppDataManager.swift
//  SingleViewTesting
//
//  Created by Jarle Heldstab on 14/01/2017.
//  Copyright © 2017 Jarle Heldstab. All rights reserved.
//

import CloudKit
import Foundation


class DataSourceManager
{
    // MARK: Static data variables
    static let sharedInstance = DataSourceManager()

    // Data
    // public let playersDataSource: PlayerDataSource
    public let guardiansDataSource: GuardianDataSource
    public let matchesDataSource: MatchDataSource
    public let teamsDataSource: TeamDataSource
    public let tournamentsDataSource: TournamentDataSource
    
    private var progressBarValue = 0.0
    {
        didSet
        {
            // self.appDataManagerDelegate?.progressBar(value: self.progressBarValue)
            switch (progressBarValue)
            {
                case 1.0:
                    print("Process is completed")
                default:
                    print("")
            }
        }
    }

    private init() {
        print("DataSourceManager init")
        guardiansDataSource = GuardianDataSource.sharedInstance
        matchesDataSource = MatchDataSource.sharedInstance
        // playersDataSource = PlayerDataSource.sharedInstance
        teamsDataSource = TeamDataSource.sharedInstance
        tournamentsDataSource = TournamentDataSource.sharedInstance
        
        // Temporarily disabling loding of csv file
//        let externalDataEnabled = false
//        if (externalDataEnabled) { FileDataSource.sharedInstance.load() }
//
//        self.players = PlayerDataSource.sharedInstance.loadPlayers()
//        self.guardians = GuardianDataSource.sharedInstance.loadGuardians()
    }

    // MARK: PlayerDataSourceHandler implementation
    public func getPlayers() -> [Player] {
        return playersDataSource.players
    }
    
    public func syncPlayersToIcloud() -> Bool {
        playersDataSource.syncPlayersToCloudKit()
        return true
    }
    
    public func save(player: Player) {
        playersDataSource.save(player: player)
    }
    
    public func delete(player: Player) {
        playersDataSource.save(player: player)
    }
    
    public func deleteCloudKitRecords() {
        guardiansDataSource.deleteCloudKitData()
        playersDataSource.deleteCloudKitData()
    }
    
    public func loadDataFromFile() {
        playersDataSource.loadDataFromFile()
        tournamentsDataSource.loadDataFromFile()
        teamsDataSource.loadDataFromFile()
        matchesDataSource.loadDataFromFile()
    }
    
    public func loadDataFromCloudKit() {
        guardiansDataSource.loadGuardiansFromCloudKit()
        playersDataSource.loadDataFromCloudKit()
    }
}

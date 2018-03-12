//
//  ViewController.swift
//  SingleViewTestingSync
//
//  Created by Jarle Heldstab on 19/01/2018.
//  Copyright © 2018 Jarle Heldstab. All rights reserved.
//

import Cocoa
import CloudKit

class ViewController: NSViewController {
    
    @IBOutlet weak var syncIcloudButton: NSButton!
    @IBOutlet weak var deleteIcloudButton: NSButton!
    @IBOutlet weak var playersTableView: NSTableView!
    @IBOutlet weak var teamTableView: NSTableView!
    @IBOutlet weak var tournamentTableView: NSTableView!
    @IBOutlet weak var matchTableView: NSTableView!
    @IBOutlet weak var playersCloudKitScrollView: NSScrollView!
    
    let dataSource = DataSourceManager.sharedInstance

    override func viewDidLoad() {
        super.viewDidLoad()
        playersTableView.delegate = self
        playersTableView.dataSource = self
        matchTableView.delegate = self
        matchTableView.dataSource = self
        teamTableView.delegate = self
        teamTableView.dataSource = self
        tournamentTableView.delegate = self
        tournamentTableView.dataSource = self
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
            print("representedObject")
        }
    }
    
    @IBAction func loadFromCloudKitButtonClicked(_ sender: Any) {
        // dataSource.loadDataFromCloudKit()
        // playersTableView.reloadData()
        let testObject = CKRecord(recordType: "MyType")
        
        testObject.setObject("Hello World" as CKRecordValue, forKey: "FirstType")

        let cloudKitDatabase2 = CKContainer(identifier: "iCloud.com.example.SingleViewTesting").publicCloudDatabase
        cloudKitDatabase2.save(testObject) { (record, error) -> Void in
            if error != nil
            {
                print(error)
                return
            }
            else
            {
                print("Saved")
            }
        }
    }
    
    @IBAction func loadFromFileButtonClicked(_ sender: Any) {
        dataSource.loadDataFromFile()
        playersTableView.reloadData()
        tournamentTableView.reloadData()
        teamTableView.reloadData()
        matchTableView.reloadData()
    }
    @IBAction func deleteIcloudButtonClicked(_ sender: NSButton) {
        dataSource.deleteCloudKitRecords()
        playersTableView.reloadData()
    }
    @IBAction func syncIcloudButtonClicked(_ sender: NSButton) {
        // dataSource.syncPlayersToIcloud()
        // playersTableView.reloadData()
        // dataSource.teamsDataSource.save(team: <#T##Team#>)
        // dataSource.tournamentsDataSource.save(tournament: <#T##Tournament#>)
        // dataSource.matchesDataSource.save(match: <#T##Match#>)
    }
}

extension ViewController: NSTableViewDataSource {
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        if(tableView == self.playersTableView) {
            return dataSource.playersDataSource.players.count
        }
        else if(tableView == self.matchTableView) {
            return dataSource.matchesDataSource.matches.count
        }
        else if(tableView == self.teamTableView) {
            return dataSource.teamsDataSource.teams.count
        }
        else if(tableView == self.tournamentTableView) {
            return dataSource.tournamentsDataSource.tournaments.count
        }
        
        return 0
    }
}

extension ViewController: NSTableViewDelegate {
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        var cellText: String = ""
        var cellIdentifier: String = ""
        
        
        if(tableView == self.playersTableView) {
            // print("playersTableView")
            if tableColumn == tableView.tableColumns[0] {
                cellIdentifier = "nummerId"
                cellText = String(dataSource.playersDataSource.players[row].teamReference)
            }
            else if tableColumn == tableView.tableColumns[1] {
                cellIdentifier = "navnId"
                cellText = dataSource.playersDataSource.players[row].firstName
            }
            else if tableColumn == tableView.tableColumns[2] {
                cellIdentifier = "epost1Id"
                cellText = dataSource.playersDataSource.players[row].guardian1!.email!
            }
            else if tableColumn == tableView.tableColumns[3] {
                cellIdentifier = "epost2Id"
                cellText = dataSource.playersDataSource.players[row].guardian2!.email!
            }
            else if tableColumn == tableView.tableColumns[4] {
                cellIdentifier = "mobil1Id"
                cellText = dataSource.playersDataSource.players[row].guardian1!.phone!
            }
            else if tableColumn == tableView.tableColumns[5] {
                cellIdentifier = "mobil2Id"
                cellText = dataSource.playersDataSource.players[row].guardian2!.phone!
            }
            else if tableColumn == tableView.tableColumns[6] {
                cellIdentifier = "playerActiveCheckBox"
                cellText = dataSource.playersDataSource.players[row].guardian2!.phone!
            }
        }
        
        if(tableView == self.matchTableView) {
            // print("tournamentTableView")
            if tableColumn == tableView.tableColumns[0] {
                cellIdentifier = "matchDate"
                let date = dataSource.matchesDataSource.matches[row].dateTime
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd.MM.yy"
                
                let mDate = dateFormatter.string(from: date)
                cellText = mDate
            }
            if tableColumn == tableView.tableColumns[1] {
                cellIdentifier = "matchTime"
                let time = dataSource.matchesDataSource.matches[row].dateTime
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "hh.mm"
                
                let mTime = dateFormatter.string(from: time)
                cellText = mTime
            }
            if tableColumn == tableView.tableColumns[2] {
                cellIdentifier = "matchHomeTeam"
                cellText = String(describing: dataSource.matchesDataSource.matches[row].teamA.name)
            }
            if tableColumn == tableView.tableColumns[3] {
                cellIdentifier = "matchAwayTeam"
                cellText = String(describing: dataSource.matchesDataSource.matches[row].teamB.name)
            }
            if tableColumn == tableView.tableColumns[4] {
                cellIdentifier = "matchTournament"
                cellText = String(describing: dataSource.matchesDataSource.matches[row].tournament!.name)
            }
        }
        
        if(tableView == self.tournamentTableView) {
            // print("tournamentTableView")
            if tableColumn == tableView.tableColumns[0] {
                cellIdentifier = "tournamentName"
                cellText = String(describing: dataSource.tournamentsDataSource.tournaments[row].name)
            }
        }
        
        if(tableView == self.teamTableView) {
            // print("teamTableView")
            if tableColumn == tableView.tableColumns[0] {
                cellIdentifier = "teamName"
                cellText = String(describing: dataSource.teamsDataSource.teams[row].name)
            }
            else if tableColumn == tableView.tableColumns[1] {
                cellIdentifier = "tournamentName"
                cellText = dataSource.teamsDataSource.teams[row].tournament!.name
            }
        }

        if let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: cellIdentifier), owner: nil) as? NSTableCellView {
            
            cell.textField?.stringValue = cellText
            return cell
        }
        return nil
    }
}


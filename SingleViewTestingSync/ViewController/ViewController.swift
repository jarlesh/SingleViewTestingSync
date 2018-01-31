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
    @IBOutlet weak var playersCloudKitScrollView: NSScrollView!
    let dataSource = DataSourceManager.sharedInstance

    override func viewDidLoad() {
        super.viewDidLoad()
        playersTableView.delegate = self
        playersTableView.dataSource = self

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
            print("representedObject")
        }
    }
    @IBAction func loadFromCloudKitButtonClicked(_ sender: Any) {
        dataSource.loadDataFromCloudKit()
        playersTableView.reloadData()
    }
    
    @IBAction func deleteIcloudButtonClicked(_ sender: NSButton) {
        dataSource.deleteCloudKitRecords()
        playersTableView.reloadData()
    }
    @IBAction func syncIcloudButtonClicked(_ sender: NSButton) {
        dataSource.syncPlayersToIcloud()
        playersTableView.reloadData()
    }
}

extension ViewController: NSTableViewDataSource {
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        // print("Setting number of rows to: \(PlayerDataSource.sharedInstance.players.count)")
        return dataSource.playerDataSource.players.count // PlayerDataSource.sharedInstance.players.count
    }
}

extension ViewController: NSTableViewDelegate {
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
//      Cannot be null:
//      guard let player = PlayerDataSource.sharedInstance.players[row] else {
//          return nil
//      }
        
        var cellText: String = ""
        var cellIdentifier: String = ""
        
        if tableColumn == tableView.tableColumns[0] {
            cellIdentifier = "nummerId"
            cellText = String(dataSource.playerDataSource.players[row].number)
        }
        else if tableColumn == tableView.tableColumns[1] {
            cellIdentifier = "navnId"
            cellText = dataSource.playerDataSource.players[row].firstName
        }
        else if tableColumn == tableView.tableColumns[2] {
            cellIdentifier = "epost1Id"
            cellText = dataSource.playerDataSource.players[row].guardian1!.email!
        }
        else if tableColumn == tableView.tableColumns[3] {
            cellIdentifier = "epost2Id"
            cellText = dataSource.playerDataSource.players[row].guardian2!.email!
        }
        else if tableColumn == tableView.tableColumns[4] {
            cellIdentifier = "mobil1Id"
            cellText = dataSource.playerDataSource.players[row].guardian1!.phone!
        }
        else if tableColumn == tableView.tableColumns[5] {
            cellIdentifier = "mobil2Id"
            cellText = dataSource.playerDataSource.players[row].guardian2!.phone!
        }
        else if tableColumn == tableView.tableColumns[6] {
            cellIdentifier = "playerActiveCheckBox"
            cellText = dataSource.playerDataSource.players[row].guardian2!.phone!
        }
        

        if let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: cellIdentifier), owner: nil) as? NSTableCellView {
            
            cell.textField?.stringValue = cellText
            // print("\(cellText)")
            return cell
        }
        return nil
//        print("Skriver ut spillere \(PlayerDataSource.sharedInstance.players[row].firstName)")
//        return PlayerDataSource.sharedInstance.players[row].firstName)
    }
}


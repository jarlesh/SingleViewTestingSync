//
//  Player.swift
//  SingleViewTesting
//
//  Created by Jarle Heldstab on 06/09/16.
//  Copyright © 2016 Jarle Heldstab. All rights reserved.
//

import CloudKit
import Foundation

class Player: Person, Comparable {
    static func <(lhs: Player, rhs: Player) -> Bool {
        //
        return true
    }
    
    static func ==(lhs: Player, rhs: Player) -> Bool {
        var returnValue = false
        if (lhs.firstName == rhs.firstName) && (lhs.lastName == rhs.lastName)
        {
            returnValue = true
        }
        return returnValue
    }
    

    // MARK: Properties
    var number = 2
    var playing: Bool
    
    var guardian1: Guardian?
    var guardian2: Guardian?
    
    var teamReference = 0
    private (set) var cloudKitRecord: CKRecord
    
    // MARK: Initialization
    init(number: Int, firstName: String, lastName: String) {
        self.number = number
        self.playing = false
        super.init(firstName: firstName, lastName: lastName)
    }
    
    init(number: Int, firstName: String, lastName: String, guardian1: Guardian, guardian2: Guardian?) {
        self.number = number
        self.playing = false
        self.guardian1 = guardian1
        self.guardian2 = guardian2
        
        super.init(firstName: firstName, lastName: lastName)
    }
    
    // MARK: New
    init(teamReference: Int, firstName: String, lastName: String, guardian1: Guardian, guardian2: Guardian?) {
        self.teamReference = teamReference
        self.playing = false
        self.guardian1 = guardian1
        self.guardian2 = guardian2
        
        super.init(firstName: firstName, lastName: lastName)
    }
    
    public func has(guardian: Guardian) {
        self.guardian1 = guardian
    }
    
    public func has(guardian1: Guardian, and guardian2: Guardian) {
        self.guardian1 = guardian1
        self.guardian2 = guardian2
    }
}


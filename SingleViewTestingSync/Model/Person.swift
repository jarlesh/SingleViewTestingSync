//
//  Person.swift
//  SingleViewTesting
//
//  Created by Jarle Heldstab on 24/08/2017.
//  Copyright © 2017 Jarle Heldstab. All rights reserved.
//

import CloudKit
import Foundation

class Person {

    // MARK: Properties
    var firstName: String
    var lastName: String
    
    // MARK: Initialization
    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
}

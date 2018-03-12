//
//  Guardian.swift
//  SingleViewTesting
//
//  Created by Jarle Heldstab on 04/12/2017.
//  Copyright © 2017 Jarle Heldstab. All rights reserved.
//

import CloudKit
import Foundation

class Guardian: Person {
    
    // MARK: Properties
    var email: String?  // { get { return "" } set {} }
    var phone: String?
    var address: String?
    var ckRecordID: CKRecordID?
    
    // MARK: Initialization
    init(firstName: String, lastName: String, email: String, phone: String, address: String) {
        self.email = email
        self.phone = phone
        self.address = ""
        super.init(firstName: firstName, lastName: lastName)
    }
    
    convenience init(withPropertiesFrom: CKRecord) {
        let argEmail = withPropertiesFrom.object(forKey: "Email") as? String
        let argPhone = withPropertiesFrom.object(forKey: "Phone") as? String
        let argFirstName = withPropertiesFrom.object(forKey: "FirstName") as! String
        let argLastName = withPropertiesFrom.object(forKey: "LastName") as! String
        // let argAddress = withPropertiesFrom.object(forKey: "Address") as! String
        
        self.init(firstName: argFirstName, lastName: argLastName, email: argEmail!, phone: argPhone!, address: "")
    }
}

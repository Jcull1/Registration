//
//  Guest.swift
//  RegistrationApp
//
//  Created by Justin Cullen on 1/4/19.
//  Copyright © 2019 Justin Cullen. All rights reserved.
//

import UIKit
import os.log
protocol  Decoder{}

class Guest: NSObject, NSCoding {
    
   
    //MARK: Properties
    var constId: String
    var firstName: String
    var lastName: String
    var email: String
    var cellPhone: String
    var guestOf: String
    var number: String
    var balanceDue: String
    
    //MARK: Archiving Paths
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("arrivedGuests")
    
    //MARK: Types
    
    struct PropertyKey{
        static let constId = "constId"
        static let firstName = "firstName"
        static let lastName = "lastName"
        static let email = "email"
        static let cellPhone = "cellPhone"
        static let guestOf = "guestOf"
        static let number = "number"
        static let balanceDue = "balanceDue"
    }
    //MARK: Initialization
    
    //Initialization should fail if there is an empty value.
    
    init?(constId: String, firstName: String, lastName: String, email: String, cellPhone: String, guestOf: String, number: String, balanceDue: String) {
        
        //Nothing should be empty
        guard !constId.isEmpty else{
            return nil
        }
        guard !firstName.isEmpty else{
            return nil
        }
        guard !lastName.isEmpty else{
            return nil
        }
        guard !email.isEmpty else{
            return nil
        }
        guard !cellPhone.isEmpty else{
            return nil
        }
        guard !guestOf.isEmpty else{
            return nil
        }
        guard !number.isEmpty else{
            return nil
        }
        guard !balanceDue.isEmpty else{
            return nil
        }
        
        //Initialize stored properties
        self.constId = constId
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.cellPhone = cellPhone
        self.guestOf = guestOf
        self.number = number
        self.balanceDue = balanceDue
    }
    
    //MARK: NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(constId, forKey: PropertyKey.constId)
        aCoder.encode(firstName, forKey: PropertyKey.firstName)
        aCoder.encode(lastName, forKey: PropertyKey.lastName)
        aCoder.encode(email, forKey: PropertyKey.email)
        aCoder.encode(cellPhone, forKey: PropertyKey.cellPhone)
        aCoder.encode(guestOf, forKey: PropertyKey.guestOf)
        aCoder.encode(number, forKey: PropertyKey.number)
        aCoder.encode(balanceDue, forKey: PropertyKey.balanceDue)
    }
    
    required convenience init?(coder aDecoder: NSCoder){
        
        guard let constId = aDecoder.decodeObject(forKey: PropertyKey.constId) as? String else{
            os_log("Unable to decide the constId for a Guest Object", log: OSLog.default, type: .debug)
            return nil
        }
        
        guard let firstName = aDecoder.decodeObject(forKey: PropertyKey.firstName) as? String else{
            os_log("Unable to decide the first name for a Guest Object", log: OSLog.default, type: .debug)
            return nil
        }
        
        guard let lastName = aDecoder.decodeObject(forKey: PropertyKey.lastName) as? String else{
            os_log("Unable to decode the last name for a Guest Object", log: OSLog.default, type: .debug)
            return nil
        }
        guard let email = aDecoder.decodeObject(forKey: PropertyKey.email) as? String else{
            os_log("Unable to decode the email for a guest object", log: OSLog.default, type: .debug)
            return nil
        }
        guard let cellPhone = aDecoder.decodeObject(forKey: PropertyKey.cellPhone) as? String else{
            os_log("Unable to decode the cell phone number for a guest object", log: OSLog.default, type: .debug)
            return nil
        }
        guard let guestOf = aDecoder.decodeObject(forKey: PropertyKey.guestOf)as? String else{
            os_log("Unable to decode the number of guest for a guest object", log: OSLog.default, type: .debug)
            return nil
        }
        guard let number = aDecoder.decodeObject(forKey: PropertyKey.number) as? String else{
            os_log("Unable to decide the number for a Guest Object", log: OSLog.default, type: .debug)
            return nil
        }
        guard let balanceDue = aDecoder.decodeObject(forKey: PropertyKey.balanceDue) as? String else{
            os_log("Unable to decide the balanceDue for a Guest Object", log: OSLog.default, type: .debug)
            return nil
        }
        
        self.init(constId: constId, firstName: firstName, lastName: lastName, email: email, cellPhone: cellPhone, guestOf: guestOf, number: number, balanceDue: balanceDue)
    }
}


//
//  RegistrationAppTests.swift
//  RegistrationAppTests
//
//  Created by Justin Cullen on 1/4/19.
//  Copyright © 2019 Justin Cullen. All rights reserved.
//

import XCTest
@testable import RegistrationApp

class RegistrationAppTests: XCTestCase {

    //MARK: Guest Class Tests
    
    //Confirm that the Guest intializer returns a Guest Object when passed valid parameters.
    func testGuestInitializationSucceeds(){
        let fieldsFilled = Guest.init(firstName: "Justin", lastName: "Cullen", email: "jcullyt1@gmail.com", cellPhoneNumber: "1234567890", numberOfGuest: "1")
        XCTAssertNotNil(fieldsFilled)
    }
    
    func testGuestInitializationFailds(){
        let emptyField = Guest.init(firstName: "", lastName: "", email: "", cellPhoneNumber: "", numberOfGuest: "")
        XCTAssertNil(emptyField)
    }
}

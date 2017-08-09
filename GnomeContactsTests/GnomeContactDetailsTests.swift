//
//  GnomeContactDetailsTests.swift
//  GnomeContacts
//
//  Created by rgonzalez on 8/4/17.
//  Copyright © 2017 batasoft. All rights reserved.
//

import XCTest
@testable import GnomeContacts

class GnomeContactDetailsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testContactsDetailsPresenter() {
        let mainViewController = ContactDetailsWireframe.mainViewController(withDetails: mockContact()) as? ContactDetailsTableViewController
        
        XCTAssertNotNil(mainViewController, "mainViewController should be not nil")
        let presenter = mainViewController?.presenter
        XCTAssertNotNil(presenter, "presenter should be not nil")
        
        XCTAssertNotNil(presenter!.contactImageURL(), "should have a image url")
        XCTAssertNotNil(presenter!.contactName(), "should have a name")
        XCTAssertNotNil(presenter!.itemsFor(row: 0), "should have items")
        XCTAssert(presenter!.totalItems() > 0, "should have at least one item")
    }

    
    func mockContact() -> ContactDetails {
        return ContactDetails(age: 166, friends: ["FizwoodVoidtossie"], hairColor: "gray", height: 106.14, id: 02, name: "Malbin Chromerocket", professions: ["Cook","Baker","Miner"], thumbnail: "http://www.publicdomainpictures.net/pictures/30000/nahled/maple-leaves-background.jpg", weight: 35.88)
    }
}

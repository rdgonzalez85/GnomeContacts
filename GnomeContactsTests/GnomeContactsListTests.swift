//
//  GnomeContactsListTests.swift
//  GnomeContactsTests
//
//  Created by rgonzalez on 8/2/17.
//  Copyright © 2017 batasoft. All rights reserved.
//

import XCTest
@testable import GnomeContacts

class GnomeContactsListTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetContacts() {
        let contactsExpectation = expectation(description: "contactsExpectation")
        let dataManager = ContactsAPIDataManager()
        
        dataManager.getContacts { (contacts, error) in
            if error == nil {
                XCTAssertNotNil(contacts, "contacts should not be nil")
                XCTAssertTrue(contacts!.count > 0, "should have at least one element")
            } else {
                XCTFail("Should have contacts")
            }
            contactsExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 5) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func testGetInitialViewController() {
        let initialViewController = ContactsWireframe.ContactsViewController() as? ContactsTableViewController
        
        XCTAssertNotNil(initialViewController, "intialViewController should be set")
        XCTAssertNotNil(initialViewController?.presenter, "presenter should be set")
        XCTAssertNotNil(initialViewController?.presenter?.interactor, "interactor should be set")
        XCTAssertNotNil(initialViewController?.presenter?.interactor?.dataManager, "dataManager should be set")
    }
    
    func testContactsPresenter() {
        let initialViewController = ContactsWireframe.ContactsViewController() as? ContactsTableViewController
        var presenter = initialViewController?.presenter
        
        XCTAssertNotNil(presenter, "presenter should be set")
        
        let delegate = PresenterDelegate()
        delegate.expectation = expectation(description: "contactsExpectation")
        
        presenter!.delegate = delegate
        
        presenter!.getContacts()
        
        waitForExpectations(timeout: 5) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
        
        XCTAssert(presenter!.totalItems() > 0, "should have at least one item")
        XCTAssertNotNil(presenter!.itemFor(row: 0), "should return an item")
        
    }
    
    
    class PresenterDelegate: ContactsPresenterDelegate {
        var expectation: XCTestExpectation?
        func showContacts() {
            expectation?.fulfill()
        }
        
        func showError(error: Error) {
            expectation?.fulfill()
        }
    }
}


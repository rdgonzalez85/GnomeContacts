//
//  ContactsInteractor.swift
//  GnomeContacts
//
//  Created by rgonzalez on 8/2/17.
//  Copyright © 2017 batasoft. All rights reserved.
//

import Foundation

protocol ContactsInteractorProtocol {
    var dataManager: ContactsDataManagerProtocol? {get}
    func getContacts(_ completitionHandler: @escaping ContactsResponse)
    func getNextContacts(_ completitionHandler: @escaping ContactsResponse)
    func hasMoreItems() -> Bool
}


class ContactsInteractor: ContactsInteractorProtocol {
    let dataManager: ContactsDataManagerProtocol?
    private var contacts: [ContactEntity]?
    
    private var start = 0
    private var count = 30
    
    init (dataManager: ContactsDataManagerProtocol) {
        self.dataManager = dataManager
    }
    
    func getContacts(_ completitionHandler: @escaping ContactsResponse) {
        dataManager?.getContacts(completitionHandler: { contacts, error in
            self.contacts = contacts
            self.getNextContacts(completitionHandler)
        })
    }
    
    func getNextContacts(_ completitionHandler: @escaping ContactsResponse) {
        
        guard let contacts = contacts else {
            completitionHandler(nil, nil)
            return
        }
        
        if start + count < contacts.count {
            defer {
                start = count
            }
            completitionHandler(Array(contacts[start..<start+count]), nil)
        } else if start < contacts.count {
            defer {
                start = count
            }
            completitionHandler(Array(contacts[start..<contacts.count-start]), nil)
        }
    }
    
    func hasMoreItems() -> Bool {
        return start < contacts?.count ?? 0
    }
    
}

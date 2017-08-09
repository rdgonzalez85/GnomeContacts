//
//  ContactsAPIDataManager.swift
//  GnomeContacts
//
//  Created by rgonzalez on 8/2/17.
//  Copyright © 2017 batasoft. All rights reserved.
//

import Foundation

typealias ContactsResponse = ([ContactEntity]?, Error?) -> Void

protocol ContactsDataManagerProtocol {
    func getContacts(completitionHandler: @escaping ContactsResponse)
}

struct ContactsAPIDataManager: ContactsDataManagerProtocol {

    private let urlString = "https://raw.githubusercontent.com/rrafols/mobile_test/master/data.json"
    
    /**
        makes a request to get a list of Contacts
        - returns: ContactsResponse
    */
    func getContacts(completitionHandler: @escaping ContactsResponse) {
        guard let url = URL(string: urlString) else {
            completitionHandler(nil, NSError(domain: "gnomeContacts", code: 1, userInfo: nil))
            return
        }
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data {
                do {
                    let jsonData = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:Any]
                    
                    var contacts: [ContactEntity]?
                    
                    if let contactsJSON = jsonData?["Brastlewark"] as? Array<Dictionary<String,Any>> {
                        
                        contacts = ContactEntity.parseJSON(objects: contactsJSON)
                    }
                    
                    completitionHandler(contacts,nil)
                } catch {
                    completitionHandler(nil, error)
                }
            }
        }.resume()
    }
}

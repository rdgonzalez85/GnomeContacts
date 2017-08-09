//
//  ContactDetailsPresenter.swift
//  GnomeContacts
//
//  Created by rgonzalez on 8/4/17.
//  Copyright © 2017 batasoft. All rights reserved.
//

import Foundation

typealias ContactDetails = ContactEntity

struct ContactInformation {
    var name: CustomStringConvertible
    var value: [CustomStringConvertible]
    
    func valueString() -> String {
        
        if value.count == 0 {
            return "None"
        }
        
        let stringValues = value.flatMap {
            String(describing: $0)
        }
        return stringValues.joined(separator: ", ")
    }
}

protocol ContactDetailsPresenterProtocol {
    func totalItems() -> Int
    func itemsFor(row: Int) -> ContactInformation
    func contactName() -> String?
    func contactImageURL() -> URL?
}

struct ContactDetailsPresenter: ContactDetailsPresenterProtocol {
    
    private struct FieldNames {
        static let name = "Name"
        static let age = "Age"
        static let friends = "Friends"
        static let hairColor = "Hair Color"
        static let height = "Height"
        static let professions = "Professions"
        static let weight = "Weight"
    }
    
    let contactDetails: ContactDetails?
    private let contactInformation: [ContactInformation]
    
    init(contactDetails: ContactDetails?) {
        self.contactDetails = contactDetails
        
        var detailInformation = [ContactInformation]()
        
        if let contactAge = contactDetails?.age {
            detailInformation.append(ContactInformation(name: FieldNames.age, value: [contactAge]))
        }
        
        if let contactFriends = contactDetails?.friends {
            detailInformation.append(ContactInformation(name: FieldNames.friends, value: contactFriends))
        }
        
        if let contactHairColor = contactDetails?.hairColor {
            detailInformation.append(ContactInformation(name: FieldNames.hairColor, value: [contactHairColor]))
        }
        
        if let contactHeight = contactDetails?.height {
            detailInformation.append(ContactInformation(name: FieldNames.height, value: [contactHeight]))
        }
        
        if let contactProfessions = contactDetails?.professions {
            detailInformation.append(ContactInformation(name: FieldNames.professions, value: contactProfessions))
        }
        
        if let contactWeight = contactDetails?.weight {
            detailInformation.append(ContactInformation(name: FieldNames.weight, value: [contactWeight]))
        }
        
        contactInformation = detailInformation
        
    }
    
    func totalItems() -> Int {
        return contactInformation.count
    }
    
    func itemsFor(row: Int) -> ContactInformation {
        return contactInformation[row]
    }
    
    func contactName() -> String? {
        return contactDetails?.name
    }
    
    func contactImageURL() -> URL? {
        guard let stringURL = contactDetails?.thumbnail else {
            return nil
        }
        
        return URL(string: stringURL)
    }
}

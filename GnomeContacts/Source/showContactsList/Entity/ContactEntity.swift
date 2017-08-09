//
//  ContactEntity.swift
//  GnomeContacts
//
//  Created by rgonzalez on 8/2/17.
//  Copyright © 2017 batasoft. All rights reserved.
//

/// Struct that represents the Contact information

struct ContactEntity {
    let age: Int?
    let friends: [String]?
    let hairColor: String?
    let height: Float?
    let id: Int?
    let name: String?
    let professions: [String]?
    let thumbnail: String?
    let weight: Float?
}

// CustomStringConvertible
extension ContactEntity: CustomStringConvertible {
    var description: String {
        return name ?? ""
    }
}

// JSON mapping support
extension ContactEntity {
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let age = "age"
        static let friends = "friends"
        static let hairColor = "hair_Color"
        static let height = "height"
        static let id = "id"
        static let name = "name"
        static let professions = "professions"
        static let thumbnail = "thumbnail"
        static let weight = "weight"
    }
    
    /**
        Parses a single JSON object into a ContactEntity
        - Parameter dictionary: JSON Dictionary representing a Contact
        - Returns: ContactEntity
    */
    
    static func parseJSON(dictionary: Dictionary<String,Any>) -> ContactEntity {
        let age = dictionary[SerializationKeys.age] as? Int
        let friends = dictionary[SerializationKeys.friends] as? [String]
        let hairColor = dictionary[SerializationKeys.hairColor] as? String
        let height = dictionary[SerializationKeys.height] as? Float
        let id = dictionary[SerializationKeys.id] as? Int
        let name = dictionary[SerializationKeys.name] as? String
        let professions = dictionary[SerializationKeys.professions] as? [String]
        let thumbnail = dictionary[SerializationKeys.thumbnail] as? String
        let weight = dictionary[SerializationKeys.weight] as? Float
        
        return ContactEntity(age: age, friends: friends, hairColor: hairColor, height: height, id: id, name: name, professions: professions, thumbnail: thumbnail, weight: weight)
    }
    
    /**
        Parses a list of json object into a list of ContactEntity.
     
        - Parameter objects: Array of JSON Contact dictionaries
        - Returns: a list of @ContactEntity
    */
    static func parseJSON(objects: Array<Dictionary<String,Any>>) -> [ContactEntity] {
        var contacts = [ContactEntity]()
        
        for object in objects {
            contacts.append(parseJSON(dictionary: object))
        }
        
        return contacts
    }
}

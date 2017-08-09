//
//  ContactDetailsWireframe.swift
//  GnomeContacts
//
//  Created by rgonzalez on 8/4/17.
//  Copyright © 2017 batasoft. All rights reserved.
//

import UIKit

struct ContactDetailsWireframe {
    static func mainViewController(withDetails details: Any?) -> UIViewController {
        if let viewController = UIStoryboard.storyboard(name: "Main", viewController: "ContactDetailsTableViewController") as? ContactDetailsTableViewController {
            
            let presenter = ContactDetailsPresenter(contactDetails: details as? ContactDetails)

            viewController.presenter = presenter
            
            return viewController
        }
        return UIViewController()
    }
}

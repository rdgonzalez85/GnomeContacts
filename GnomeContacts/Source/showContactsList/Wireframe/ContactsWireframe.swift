//
//  ContactsWireframe.swift
//  GnomeContacts
//
//  Created by rgonzalez on 8/2/17.
//  Copyright © 2017 batasoft. All rights reserved.
//

import UIKit

struct ContactsWireframe {
    
    // get the ViewContoller with all the VIPER connections
    static func ContactsViewController() -> UIViewController {
    
        if let mainVC = UIStoryboard.storyboard(name: "Main", viewController: "ContactsTableViewController") as? ContactsTableViewController {
            
            let dataManager = ContactsAPIDataManager()
            
            let interactor = ContactsInteractor(dataManager: dataManager)
            
            let presenter = ContactsPresenter(interactor: interactor, delegate: mainVC , dataLoadingDelegate: mainVC)
                
            mainVC.presenter = presenter

            return mainVC
        }
        return UIViewController()
    }
    
    // navigates to the details screen
    static func navigateToDetails(withDetails details: Any) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let destination = ContactDetailsWireframe.mainViewController(withDetails: details)
        appDelegate.mainNavigationController.show(destination, sender: nil)
    }
}

// extension to load UIViewControllers from UIStoryboard
extension UIStoryboard {
    class func storyboard(name: String, viewController: String) -> UIViewController {
        return UIStoryboard.init(name: name, bundle: nil).instantiateViewController(withIdentifier: viewController)
    }
}

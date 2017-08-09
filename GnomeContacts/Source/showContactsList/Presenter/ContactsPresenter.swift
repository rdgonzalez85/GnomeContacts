//
//  ContactsPresenter.swift
//  GnomeContacts
//
//  Created by rgonzalez on 8/2/17.
//  Copyright © 2017 batasoft. All rights reserved.
//

import Foundation

//MARK: DataLoadingDelegate
/// Delegate to inform about loading information
protocol DataLoadingDelegate: class {
    func dataLoadingStarted()
    func dataLoadingFinished()
}

//MARK: ContactsPresenterProtocol
/// Contacts Presenter Protocol 
/// The Presenter in viPer
protocol ContactsPresenterProtocol {
    var interactor: ContactsInteractorProtocol? {get}
    var delegate: ContactsPresenterDelegate? {get set}
    func getContacts()
    func getNextItems()
    func itemFor(row: Int) -> CustomStringConvertible?
    func totalItems() -> Int
    func contactSelected(row: Int)
}

//MARK: ContactsPresenterDelegate
/// Delegate to inform when the information is ready to be presented
protocol ContactsPresenterDelegate: class {
    func showContacts()
    func showError(error: Error)
}

class ContactsPresenter: ContactsPresenterProtocol {
    /// The interactor in vIper
    var interactor: ContactsInteractorProtocol?
    
    weak var delegate: ContactsPresenterDelegate?
    
    weak var dataLoadingDelegate: DataLoadingDelegate?
    
    private var contacts: [ContactEntity]? = nil
    
    convenience init(interactor: ContactsInteractorProtocol?, delegate: ContactsPresenterDelegate?, dataLoadingDelegate: DataLoadingDelegate?) {
        self.init()
        self.interactor = interactor
        self.delegate = delegate
        self.dataLoadingDelegate = dataLoadingDelegate
    }

    /// retrieve the contacts from the interactor 
    func getContacts() {
        dataLoadingDelegate?.dataLoadingStarted()
        interactor?.getContacts({ contacts, error in
            self.contacts = contacts
            // we need to be sure to dispatch to main queue
            DispatchQueue.main.async {
                self.dataLoadingDelegate?.dataLoadingFinished()
                if error == nil {
                    self.delegate?.showContacts()
                } else {
                    self.delegate?.showError(error: error!)
                }
            }
        })
    }
    
    func getNextItems() {
        guard let interactor = interactor else {
            return
        }
        
        if interactor.hasMoreItems() {
            interactor.getNextContacts({ newContacts, error in
                if let newContacts = newContacts {
                    self.contacts?.append(contentsOf: newContacts)
                }
                // we need to be sure to dispatch to main queue
                DispatchQueue.main.async {
                    if error == nil {
                        self.delegate?.showContacts()
                    } else {
                        self.delegate?.showError(error: error!)
                    }
                }
            })
        }
        
    }
    
    func itemFor(row: Int) -> CustomStringConvertible? {
        return contacts?[row]
    }
    
    func totalItems() -> Int {
        return contacts?.count ?? 0
    }
    
    func contactSelected(row: Int) {
        guard let item = itemFor(row: row) else {
            return
        }
        
        ContactsWireframe.navigateToDetails(withDetails: item)
    }
}

//
//  ContactsTableViewController.swift
//  GnomeContacts
//
//  Created by rgonzalez on 8/2/17.
//  Copyright © 2017 batasoft. All rights reserved.
//

import UIKit

class ContactsTableViewController: UITableViewController {

    var presenter: ContactsPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        createLoadingCell()

        presenter?.getContacts()
        
        tableView.tableFooterView = UIView()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        if isLoading { return 1 }
        
        return presenter != nil ? 1 :  0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isLoading ? 1 : presenter?.totalItems() ?? 0
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isLoading {
            return loadingCell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath)
        
        cell.textLabel?.text = presenter?.itemFor(row: indexPath.row)?.description
        
        return cell
    }
    
    var isLoadingNextElements = false
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let presenter = presenter else {
            return
        }
        
        if indexPath.row == presenter.totalItems() - 1 && !isLoadingNextElements {
            isLoadingNextElements = true
            presenter.getNextItems()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.contactSelected(row: indexPath.row)
    }
    
    var loadingCell: UITableViewCell!
    let loadingIndexPath = IndexPath(row: 0, section: 0)
    
    func createLoadingCell() {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "loadingCell") else {
            return
        }
        loadingCell = cell
        print("")
    }
    var isLoading = false
}

// MARK: - ContactsPresenterDelegate
extension ContactsTableViewController: ContactsPresenterDelegate {
    func showError(error: Error) {
        isLoadingNextElements = false
    }

    func showContacts() {
        isLoadingNextElements = false
        tableView.reloadData()
    }
}

// MARK: - DataLoadingDelegate
extension ContactsTableViewController: DataLoadingDelegate {
    func dataLoadingStarted() {
        isLoading = true
        tableView.reloadData()
    }
    
    func dataLoadingFinished() {
        isLoading = false
        tableView.reloadData()
    }
}

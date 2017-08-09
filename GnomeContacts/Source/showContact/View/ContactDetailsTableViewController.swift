//
//  ContactDetailsTableViewController.swift
//  GnomeContacts
//
//  Created by rgonzalez on 8/4/17.
//  Copyright © 2017 batasoft. All rights reserved.
//

import UIKit
import SDWebImage

class ContactDetailsTableViewController: UITableViewController {
    
    var presenter: ContactDetailsPresenterProtocol?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var contactImage: UIImageView!
    @IBOutlet weak var imageLoadingIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        nameLabel.text = presenter?.contactName()
        contactImage.setRoundedCorners()
        imageLoadingIndicator.startAnimating()
        contactImage.sd_setImage(with: presenter?.contactImageURL(), completed: { _ in
            self.imageLoadingIndicator.stopAnimating()
        })
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return presenter != nil ? 1: 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.totalItems() ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactDetailCell", for: indexPath)

        let item = presenter?.itemsFor(row: indexPath.row)
        cell.textLabel?.text = item?.name.description
        cell.detailTextLabel?.text = item?.valueString()

        return cell
    }
}

extension UIImageView {
    func setRoundedCorners() {
        layer.borderWidth = 0.5
        layer.masksToBounds = false
        layer.borderColor = UIColor.lightGray.cgColor
        layer.cornerRadius = frame.height/2
        clipsToBounds = true
    }
}

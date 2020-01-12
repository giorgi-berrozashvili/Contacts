//
//  ListViewController.swift
//  Contacts
//
//  Created by Giorgi Berozashvili on 1/11/20.
//  Copyright © 2020 GB. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    var viewModel: ListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        
        var c = Contact(firstName: "cfds", lastName: nil, company: "comp", mobileNumbers: [
            MobileNumber(description: "er", number: "1234")
        ])
        
    }
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}

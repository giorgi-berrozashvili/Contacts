//
//  ContactDetailController.swift
//  Contacts
//
//  Created by Giorgi Berozashvili on 1/13/20.
//  Copyright © 2020 GB. All rights reserved.
//

import UIKit

class ContactDetailController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var viewModel: ContactDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareActorAndViewModel()
        registerTableView()
    }
    
    
    func prepareActorAndViewModel() {
        let actor = ContactDetailActor(with: self)
        viewModel = ContactDetailViewModel(with: actor)
    }
}

extension ContactDetailController: UITableViewDelegate, UITableViewDataSource {
    
    func registerTableView() {
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.tableFooterView = UIView()
        
        let cellItems = viewModel.sections.flatMap({
            section in section.items
        })
        cellItems.forEach({ item in
            tableView.register(UINib(nibName: item.nibName, bundle: nil), forCellReuseIdentifier: item.identificator)
        })
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.sections[section].items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = viewModel.sections[indexPath]
        let cell = tableView.dequeueReusableCell(withIdentifier: model.identificator, for: indexPath)
        if var cell = cell as? Configurable {
            cell.configurator = model
        }
        cell.selectionStyle = .none
        return cell
    }
    
    
}


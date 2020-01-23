//
//  ListViewController.swift
//  Contacts
//
//  Created by Giorgi Berozashvili on 1/11/20.
//  Copyright © 2020 GB. All rights reserved.
//

import UIKit

class ContactListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var viewModel: ContactViewModel!
    var showingFavorites = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareActorAndViewModel()
        registerTableView()
    }
    
    func prepareActorAndViewModel() {
        let actor = ContactActor(with: self)
        viewModel = ContactViewModel(with: actor)
    }
    
    func refresh() {
        viewModel = ContactViewModel(with: viewModel.actor, onlyFavorites: showingFavorites)
        tableView.reloadData()
    }
    
    @IBAction func tappedFavorite(_ sender: UIButton) {
        showingFavorites = !showingFavorites
        refresh()
        sender.setImage(
            showingFavorites ? UIImage(systemName: viewModel.keywords.filledStar)
                             : UIImage(systemName: viewModel.keywords.star),
            for: .normal
        )
    }
    
    @IBAction func tappedAdd(_ sender: UIButton) {
        viewModel.actor.showNewContactViewController()
    }
}

extension ContactListViewController: UITableViewDelegate, UITableViewDataSource {
    
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
        tableView.register(UINib(nibName: "ContactInputCell", bundle: nil), forCellReuseIdentifier: "NewContactInputCell")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.sections[section].title?.uppercased()
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let model = viewModel.sections[section]
        if let view = view as? UITableViewHeaderFooterView {
            view.textLabel?.font = model.titleFont
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return viewModel.sections[section].height
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.sections[section].items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = viewModel.sections[indexPath]
        let cell = tableView.dequeueReusableCell(withIdentifier: model.identificator, for: indexPath)
        cell.selectionStyle = .none
        if var cell = cell as? Configurable {
            cell.configurator = model
        }
        if var cell = cell as? Delegable {
            cell.delegate = self
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.sections[indexPath].height
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.actor.deleteRow(with: viewModel.sections[indexPath])
        }
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return viewModel.keywords.deleteWithSwipe
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.actor.didSelectContactCell(with: viewModel.sections[indexPath])
    }
}

extension ContactListViewController: ContactCellDelegate {
    func didTapStarButton(_ id: Int) {
        viewModel.actor.didTapCellFavoriteButtonWith(id: id)
    }
}

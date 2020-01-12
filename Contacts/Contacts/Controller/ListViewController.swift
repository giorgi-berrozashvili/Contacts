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
    var showingFavorites = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareActorAndViewModel()
        registerTableView()
    }
    
    func prepareActorAndViewModel() {
        let actor = ContactActor(with: self)
        viewModel = ListViewModel(with: actor)
    }
    
    func refresh() {
        viewModel = ListViewModel(with: viewModel.actor, onlyFavorites: showingFavorites)
        tableView.reloadData()
    }
    
    @IBAction func tappedFavorite(_ sender: UIButton) {
        showingFavorites = !showingFavorites
        refresh()
        sender.setImage(
            showingFavorites ? UIImage(systemName: "star.fill")
                             : UIImage(systemName: "star"),
            for: .normal
        )
    }
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    
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
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.sections[section].title.uppercased()
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
        let model = viewModel.sections[indexPath.section].items[indexPath.row]
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
        return viewModel.sections[indexPath.section].items[indexPath.row].height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRowAt(indexPath)
    }
}

extension ListViewController: ContactCellDelegate {
    func didTapStarButton(_ id: Int) {
        viewModel.actor.didTapCellFavoriteButtonWith(id: id)
    }
}

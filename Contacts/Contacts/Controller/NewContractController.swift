//
//  NewContractController.swift
//  Contacts
//
//  Created by Giorgi Berozashvili on 1/16/20.
//  Copyright © 2020 GB. All rights reserved.
//

import UIKit

class NewContractController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    
    var viewModel: NewContactViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareActorAndViewModel()
        registerTableView()
        
        cancelButton.addTarget(self, action: #selector(didTapCancelButton), for: .touchUpInside)
        doneButton.addTarget(self, action: #selector(didTapDoneButton), for: .touchUpInside)
    }
    
    func prepareActorAndViewModel() {
        let actor = NewContactActor(with: self)
        viewModel = NewContactViewModel(with: actor)
    }
    
    @objc func didTapCancelButton() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func didTapDoneButton() {
        viewModel.actor.willSaveNewContact(with: viewModel.sections)
        self.dismiss(animated: true, completion: nil)
    }
}

extension NewContractController: UITableViewDelegate, UITableViewDataSource {
    
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = viewModel.sections[indexPath]
        viewModel.actor.didSelectRow(with: model, in: &viewModel.sections)
        tableView.reloadData()
    }
}

extension NewContractController: ContactImageCellDelegate {
    func didTapAddButton() {
        viewModel.actor.didTapAddImageButton()
    }
}

extension NewContractController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.editedImage] as? UIImage {
            viewModel.actor.updateContact(image: image, in: &viewModel.sections)
            tableView.reloadData()
        }
        picker.dismiss(animated: true, completion: nil)
    }
}

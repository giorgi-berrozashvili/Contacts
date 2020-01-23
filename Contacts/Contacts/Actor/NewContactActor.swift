//
//  NewContactActor.swift
//  Contacts
//
//  Created by Giorgi Berozashvili on 1/16/20.
//  Copyright © 2020 GB. All rights reserved.
//

import UIKit

class NewContactActor {
    var viewController: NewContractController
    
    init(with viewController: NewContractController) {
        self.viewController = viewController
    }
    
    func fetchNewContactView(_ completion: @escaping (ApiResponse<[Section]>) -> ()) {
        NewContactWorker.fetchNewContactView(completion)
    }
    
    func didTapAddImageButton() {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        viewController.present(imagePicker, animated: true)
        imagePicker.delegate = viewController
    }
    
    func updateContact(image: UIImage, in sections: inout [Section]) {
        NewContactWorker.updateContact(image: image, in: &sections)
    }
    
    func didSelectRow(with model: CellItem, in sections: inout [Section]) {
        
        guard model is NewContactAddPhoneCellViewModel else { return }
        NewContactWorker.addNewPhoneField(to: &sections)
    }
    
    func willSaveNewContact(with viewModel: [Section]) {
        NewContactWorker.saveNewContact(with: viewModel)
        Notificator.notify(with: "refresh.list.controller")
    }
}

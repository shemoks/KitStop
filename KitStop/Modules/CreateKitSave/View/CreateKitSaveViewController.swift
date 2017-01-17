//
//  CreateKitSaveViewController.swift
//  KitStop
//
//  Created by Dmitriy Melnichenko on 13/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

import Chamomile

// MARK: - CreateKitSaveViewController

final class CreateKitSaveViewController: UIViewController, FlowController {

    // MARK: - VIPER stack

    var presenter: CreateKitSaveViewOutput!
    
    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Lifecycle 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Kits / Camera"
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(tapOnSave))
        navigationItem.rightBarButtonItem?.tintColor = UIColor(colorLiteralRed: 255/255.0, green: 136/255.0, blue: 48/255.0, alpha: 1.0)
    }
    
    func tapOnSave() {
        
    }

}

// MARK: - CreateKitSaveViewInput

extension CreateKitSaveViewController: CreateKitSaveViewInput {

}

// MARK: - UITableViewDelegate 

extension CreateKitSaveViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height/2.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

// MARK: - UItableViewDataSource

extension CreateKitSaveViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "KitAdditionalInfoCell", for: indexPath) as! KitAdditionalInfoCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
}

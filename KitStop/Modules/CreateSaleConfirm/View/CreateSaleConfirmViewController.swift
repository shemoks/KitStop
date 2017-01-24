//
//  CreateSaleConfirmViewController.swift
//  KitStop
//
//  Created by Dmitriy Melnichenko on 05/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

import Chamomile

// MARK: - CreateSaleConfirmViewController

final class CreateSaleConfirmViewController: UIViewController, FlowController {

    // MARK: - VIPER stack

    
    var presenter: CreateSaleConfirmViewOutput!
    
    
    //MARK: - Life cycle 
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setDetails()
        self.title = "For Sale / Camera"
        tableView.register(UINib(nibName: "SaleInfoCell", bundle: nil), forCellReuseIdentifier: "SaleInfoCell")
        
        tableView.delegate = self
        tableView.dataSource = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(tapOnSave))
        navigationItem.rightBarButtonItem?.tintColor = UIColor(colorLiteralRed: 255/255.0, green: 136/255.0, blue: 48/255.0, alpha: 1.0)
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    
    func tapOnSave() {
        
    }

}

// MARK: - CreateSaleConfirmViewInput

extension CreateSaleConfirmViewController: CreateSaleConfirmViewInput {

}

extension CreateSaleConfirmViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height/4.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension CreateSaleConfirmViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SaleInfoCell", for: indexPath) as? SaleInfoCell
        cell?.configure(detail: presenter.detail(for: indexPath))
        return cell!
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
}

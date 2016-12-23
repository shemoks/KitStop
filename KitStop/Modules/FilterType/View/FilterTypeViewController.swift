//
//  FilterTypeViewController.swift
//  KitStop
//
//  Created by Shemshur Oksana on 20/12/2016.
//  Copyright © 2016 MoziDev. All rights reserved.
//

import Chamomile

// MARK: - FilterTypeViewController

final class FilterTypeViewController: UIViewController, FlowController {

    // MARK: - VIPER stack

    var presenter: FilterTypeViewOutput!

}

// MARK: - FilterTypeViewInput

extension FilterTypeViewController: FilterTypeViewInput {

}

extension FilterTypeViewController: UITableViewDataSource {


    func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.categoryList().count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? TypeCell
        cell?.configure(filter: presenter.categoryList())
        cell?.accessoryType = .checkmark
        return cell!
    }

}

// MARK: - UITableViewDelegate

extension FilterTypeViewController: UITableViewDelegate {

   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
    
}

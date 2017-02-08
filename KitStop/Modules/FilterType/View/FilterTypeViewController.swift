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
    //    var lastSelectedIndexPath: IndexPath? = nil

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "ApplyCell", bundle: nil), forCellReuseIdentifier: "ApplyCell")
        tableView.register(UINib(nibName: "CategoryCell", bundle: nil), forCellReuseIdentifier: "Cell")
    }

}

// MARK: - FilterTypeViewInput

extension FilterTypeViewController: FilterTypeViewInput {

}

extension FilterTypeViewController: UITableViewDataSource {


    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfCategories()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CategoryCellWithImage
        cell.configureCell(category: presenter.category(for: indexPath))
        return cell
    }

}


// MARK: - UITableViewDelegate

extension FilterTypeViewController: UITableViewDelegate {


    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
        presenter.returnCategory(index: indexPath)
    }
    
}



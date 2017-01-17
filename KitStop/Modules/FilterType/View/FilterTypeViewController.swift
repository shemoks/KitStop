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
    var lastSelectedIndexPath: IndexPath? = nil

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "ApplyCell", bundle: nil), forCellReuseIdentifier: "ApplyCell")
    }

}

// MARK: - FilterTypeViewInput

extension FilterTypeViewController: FilterTypeViewInput {

}

extension FilterTypeViewController: UITableViewDataSource {


    func numberOfSections(in tableView: UITableView) -> Int {

        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        switch section {
        case 0:
            return presenter.numberOfCategories()
        default:
            return 1
        }

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CategoryCell
            cell.configure(with: presenter.category(for: indexPath))
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ApplyCell", for: indexPath) as! ApplyCell
            return cell
        }

    }

}

// MARK: - UITableViewDelegate

extension FilterTypeViewController: UITableViewDelegate {


    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.section {
        case 0:
            tableView.deselectRow(at: indexPath, animated: true)
            if indexPath.row != lastSelectedIndexPath?.row {
                if let lastSelectedIndexPath = lastSelectedIndexPath {
                    let oldCell = tableView.cellForRow(at: lastSelectedIndexPath as IndexPath)
                    oldCell?.accessoryType = .none
                }

                let newCell = tableView.cellForRow(at: indexPath)
                newCell?.tintColor = UIColor(red: 255/255, green: 136/255, blue: 48/255, alpha: 1)
                newCell?.accessoryType = .checkmark
                lastSelectedIndexPath = indexPath

            }
        default:
            let cell = tableView.cellForRow(at: indexPath)
            cell?.accessoryType = .none
            if lastSelectedIndexPath != nil {
                let currentCategory = presenter.category(for: lastSelectedIndexPath!)
                presenter.returnCategory(category: currentCategory)
            }
        }
    }


}



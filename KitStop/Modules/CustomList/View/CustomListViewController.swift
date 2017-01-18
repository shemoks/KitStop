//
//  CustomListViewController.swift
//  KitStop
//
//  Created by Shemshur Oksana on 12/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

import Chamomile

// MARK: - CustomListViewController

final class CustomListViewController: UIViewController, FlowController {

    // MARK: - VIPER stack

    var presenter: CustomListViewOutput!

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

// MARK: - FilterTypeViewInput

extension CustomListViewController: CustomListViewInput {

}

extension CustomListViewController: UITableViewDataSource {


    func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return presenter.numberOfElements()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = presenter.elementList(for: indexPath)
        return cell
    }

}

// MARK: - UITableViewDelegate

extension CustomListViewController: UITableViewDelegate {


    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.handleCellTap(for: indexPath)

    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = HeaderViewCreatePost()
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }

}

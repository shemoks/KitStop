//
//  FilterBrandViewController.swift
//  KitStop
//
//  Created by Shemshur Oksana on 20/12/2016.
//  Copyright © 2016 MoziDev. All rights reserved.
//

import Chamomile

// MARK: - FilterBrandViewController

final class FilterBrandViewController: UIViewController, FlowController {

    // MARK: - VIPER stack

    @IBOutlet weak var tableView: UITableView!
    var presenter: FilterBrandViewOutput!

    @IBAction func handleApplyTap(_ sender: Any) {
        presenter.selectedBrands(brands: [])
    }
}

// MARK: - FilterBrandViewInput

extension FilterBrandViewController: FilterBrandViewInput {


}

extension FilterBrandViewController: UITableViewDataSource {


    func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.brandList().count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? TypeCell
        cell?.configure(filter: presenter.brandList())
        cell?.accessoryType = .checkmark
        return cell!
    }

}

// MARK: - UITableViewDelegate

extension FilterBrandViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = HeaderView()
        view.headLabel.text = ""
        return view
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 54
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = HeaderView()
        view.headLabel.text = ""
        return view
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 54
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
    
}

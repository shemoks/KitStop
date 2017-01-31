//
//  CustomInputViewController.swift
//  KitStop
//
//  Created by Shemshur Oksana on 13/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

import Chamomile

// MARK: - CustomInputViewController

final class CustomInputViewController: UIViewController, FlowController {

    // MARK: - VIPER stack

    @IBOutlet weak var tableView: UITableView!
    var presenter: CustomInputViewOutput!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "CustomInputCell", bundle: nil), forCellReuseIdentifier: "CustomInputCell")
        presenter.handleViewDidLoad()
    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.backBarButtonItem?.title = ""
    }
    
    @IBAction func saveTap(_ sender: Any) {
        presenter.returnOther(dataText: presenter.getText())
    }
}

// MARK: - CustomInputViewInput

extension CustomInputViewController: CustomInputViewInput {

    func reloadData() {
        tableView.reloadData()
    }

}

extension CustomInputViewController: UITableViewDataSource {


    func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomInputCell") as? CustomInputCell
        cell?.configure(property: presenter.inputData(for: indexPath))
        return cell!
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

        return presenter.getTitle()

    }

}

// MARK: - UITableViewDelegate

extension CustomInputViewController: UITableViewDelegate {


    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }


    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {

        return 56
    }
    
}

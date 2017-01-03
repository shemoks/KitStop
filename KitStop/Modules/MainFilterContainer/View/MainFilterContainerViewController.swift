//
//  MainFilterContainerViewController.swift
//  KitStop
//
//  Created by Sasha Atamanskiy on 19/12/2016.
//  Copyright © 2016 MoziDev. All rights reserved.
//

import Chamomile

// MARK: - MainFilterContainerViewController

final class MainFilterContainerViewController: UIViewController, FlowController {

    // MARK: - VIPER stack

    @IBOutlet weak var filter: UIButton!
    @IBOutlet weak var kitSegmentControl: UISegmentedControl!
    var transferData: MainFilterContainerTransferDataProtocol?
    
    var presenter: MainFilterContainerViewOutput!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func tapOnFilterButton(_ sender: Any) {
        presenter.openFilterModule(selectedIndex: kitSegmentControl.selectedSegmentIndex)
    }
    
    @IBAction func tapOnSearchButton(_ sender: Any) {
        presenter.openSearchModule()
    }
    
    @IBAction func changeKitsElement(_ sender: Any) {
        fetchKits()
    }
    
    func fetchKits() {
        presenter.handleKitsForCategory(category: kitSegmentControl.selectedSegmentIndex, transferData: self.transferData, filterButton: filter)
    }
}

// MARK: - MainFilterContainerViewInput

extension MainFilterContainerViewController: MainFilterContainerViewInput {
    func transferKits(kits: [Product]) {
        transferData?.kitItems(transferData: kits)
    }
}

//
//  MainFilterContainerViewController.swift
//  KitStop
//
//  Created by Sasha Atamanskiy on 19/12/2016.
//  Copyright © 2016 MoziDev. All rights reserved.
//

import Chamomile

// MARK: - MainFilterContainerViewController

final class MainFilterContainerViewController: UIViewController, FlowController, MainViewPassDataProtocol, Alertable {

    // MARK: - VIPER stack

    @IBOutlet weak var filter: UIButton!
    @IBOutlet weak var kitSegmentControl: UISegmentedControl!
    var transferData: MainFilterContainerTransferDataProtocol?
    
    var presenter: MainFilterContainerViewOutput!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let main = (self.parent as! MainViewController)
        main.delegate = self
    }
    
    @IBAction func tapOnFilterButton(_ sender: Any) {
        presenter.openFilterModule(selectedIndex: kitSegmentControl.selectedSegmentIndex)
    }
    
    @IBAction func tapOnSearchButton(_ sender: Any) {
        presenter.openSearchModule(selectedSegment: kitSegmentControl.selectedSegmentIndex)
    }
    
    @IBAction func changeKitsElement(_ sender: Any) {
        transferData?.clearKitsPage()
        fetchKits()
    }
    
    func refreshKits() {
        presenter.handleKitsForCategory(category: kitSegmentControl.selectedSegmentIndex, transferData: self.transferData, filterButton: filter)
    }
    
    func fetchKits() {
        filter.setImage(UIImage.init(named: "filter_icon"), for: .normal)
        presenter.handleKitsForCategory(category: kitSegmentControl.selectedSegmentIndex, transferData: self.transferData, filterButton: filter)
    }
    
    func passData(selectedItem: Int) {
        kitSegmentControl.selectedSegmentIndex = selectedItem
        fetchKits()
    }
    
    func selectedKits(kitId: String, ownerId: String) {
        if kitSegmentControl.selectedSegmentIndex == 0 {
            presenter.openKitsModule(segmentedIndex: true, kitId: kitId, ownerId: ownerId)
        } else if kitSegmentControl.selectedSegmentIndex == 1 {
            presenter.openKitsModule(segmentedIndex: false, kitId: kitId, ownerId: ownerId)
        }
        else if kitSegmentControl.selectedSegmentIndex == 2 {
            presenter.openKitFolioDetailedModule(kitId: kitId, ownerId: ownerId)
        }
    }
    
    func showAlert(title: String, message: String) {
        let action = UIAlertAction(title: "Ok", style: .default, handler: {
            _ in
            self.transferData?.stopRefresh()
        })
        showAlertWithTitle(title, message: message, actions: [action])
    }
}

// MARK: - MainFilterContainerViewInput

extension MainFilterContainerViewController: MainFilterContainerViewInput {
    func transferKits(kits: [Product]) {
        filter.setImage(UIImage.init(named: "filter_active_icon"), for: .normal)
        transferData?.kitItems(transferData: kits)
    }
}

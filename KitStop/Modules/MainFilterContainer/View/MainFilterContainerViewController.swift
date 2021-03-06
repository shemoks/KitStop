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
        refreshKitsWithFilter()
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
        transferData?.stopRefresh()
        transferData?.page = 1
        transferData?.startActivityIndicator()
        //self.addLoadingIndicatorView()
        presenter.changeCollectionViewStatus(index: kitSegmentControl.selectedSegmentIndex)
        fetchKits()
    }
    
    func refreshKitsWithFilter() {
        transferData?.stopRefresh()
        transferData?.page = 1
        transferData?.startActivityIndicator()
        //self.addLoadingIndicatorView()
        presenter.changeCollectionViewStatus(index: kitSegmentControl.selectedSegmentIndex)
        presenter.handleKitsForCategory(category: kitSegmentControl.selectedSegmentIndex, transferData: self.transferData, filterButton: filter)
    }
    
    func refreshKits() {
        presenter.changeCollectionViewStatus(index: kitSegmentControl.selectedSegmentIndex)
        KitRealmManager.sharedManager.showCollectionView = false
        presenter.handleKitsForCategory(category: kitSegmentControl.selectedSegmentIndex, transferData: self.transferData, filterButton: filter)
    }
    
    func fetchKits() {
        KitRealmManager.sharedManager.showCollectionView = false
        presenter.handleKitsForCategory(category: kitSegmentControl.selectedSegmentIndex, transferData: self.transferData, filterButton: filter)
    }
    
    func passData(selectedItem: Int) {
        kitSegmentControl.selectedSegmentIndex = selectedItem
        transferData?.page = 1
        presenter.changeCollectionViewStatus(index: kitSegmentControl.selectedSegmentIndex)
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
        self.transferData?.stopRefresh()
        showAlertWithTitle(title, message: message)
    }
}

// MARK: - MainFilterContainerViewInput

extension MainFilterContainerViewController: MainFilterContainerViewInput {
    func stopRefresh() {
        transferData?.stopRefresh()
    }

    func stopActivityIndicator() {
        transferData?.stopActivityIndicator()
    }
    
    func stopInfiniteScroll(finishSuccess: Bool) {
        if !finishSuccess {
            transferData?.page -= 1
        }
        transferData?.finishInfiniteScroll()
    }
}

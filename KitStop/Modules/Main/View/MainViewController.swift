//
//  MainViewController.swift
//  KitStop
//
//  Created by Sasha Atamanskiy on 16/12/2016.
//  Copyright © 2016 MoziDev. All rights reserved.
//

import Chamomile
import UIKit
import KeychainAccess
import RealmSwift
import UIScrollView_InfiniteScroll

// MARK: - MainViewController

final class MainViewController: UIViewController, FlowController, MainFilterContainerTransferDataProtocol, Alertable {
    
    // MARK: - VIPER stack
    
    @IBOutlet weak var loadingIndicatorView: UIView!
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var toolbarContainer: UIView!
    
    var presenter: MainViewOutput!
    var refreshControl = UIRefreshControl()
    fileprivate var kits: [Product] = []
    var delegate: MainViewPassDataProtocol?
    fileprivate var refreshStatus = false
    var page = 1

    @IBAction func unwind(segue: UIStoryboardSegue) {

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        addLoadingIndicatorView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //LoadingIndicatorView.hide()
        collectionView.delegate = self
        collectionView.dataSource = self
        addSectionInset()
        addNavigationBarItems()
        addRefreshControl()
        addNotificationToken()
        addInfiniteScroll()
    }

    
    func addNotificationToken() {
        presenter.notificationCenter = KitRealmManager.sharedManager.getRealm().addNotificationBlock({
            [weak self] (changes: RealmCollectionChange) in
            guard let collectionView = self?.collectionView else {return}
            collectionView.reloadData()
        })
        
    }
    
    func addInfiniteScroll() {
        self.collectionView.addInfiniteScroll(handler: {
            scrollView in
            self.page += 1
            self.delegate?.fetchKits()
        })
    }
    
    deinit {
        presenter.notificationCenter?.stop()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        refresh()
    }
    
    func addRefreshControl() {
        refreshControl.bounds = CGRect.init(x: refreshControl.bounds.origin.x, y: 25, width: refreshControl.bounds.size.width, height: refreshControl.bounds.size.height)
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        collectionView.addSubview(refreshControl)
    }
    
    func refresh() {
        print("refresh")
        page = 1
        delegate?.refreshKits()
        refreshStatus = true
    }
    
    func addTap() {
        presenter.setupAlert()
    }
    
    func addNavigationBarItems() {
        self.navigationItem.titleView = UIImageView.init(image: UIImage.init(named: "navigation_logo"))
        self.navigationController?.navigationBar.tintColor = UIColor(red: 255/255, green: 136/255, blue: 48/255, alpha: 1)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "add_icon"), style: .done, target: self, action: #selector(addTap))
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor.init(patternImage: UIImage.init(named: "navigation_bar_pattern_image")!)
    }
    
    func addSectionInset() {
        let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsetsMake((self.navigationController?.navigationBar.frame.size.height)! , 0, 0, 0)
        collectionView.collectionViewLayout = layout
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let container = segue.destinationViewController(ofType: MainFilterContainerViewController.self)
        container?.transferData = self
    }
    
    func passDataToSubmodule() {
        delegate?.passData(selectedItem: 2)
    }

    func passData(index: Bool) {
        if index {
        delegate?.passData(selectedItem: 0)
        } else {
            delegate?.passData(selectedItem: 1)
        }
    }

//    func addToolbar() {
//        let toolBar = UIView.loadFromNibNamed(nibNamed: "BottomBar")
//        
//        toolBar?.frame = CGRect(x: 0, y: 0, width: toolbarContainer.frame.width, height: toolbarContainer.frame.height)
//        
//        (toolBar as? BottomBarViewController)?.tappedItem = self
//        toolbarContainer.addSubview(toolBar!)
//        
//    }

    func stopRefresh() {
        self.refreshControl.endRefreshing()
    }
    
    func addSpinner() {
        self.addLoadingIndicatorView()
    }
    
    func removeSpinner() {
        self.removeLoadingIndicatorView()
    }
    
    func finishInfiniteScroll() {
        self.collectionView.finishInfiniteScroll()
    }
}

// MARK: - MainViewInput

extension MainViewController: MainViewInput {
    
    func addLoadingIndicatorView() {
        loadingIndicatorView.isHidden = false
        LoadingIndicatorView.show(loadingIndicatorView, true)
    }
    
    func removeLoadingIndicatorView() {
        loadingIndicatorView.isHidden = true
    }
    
    func presentAlert(alertController: UIAlertController) {
        self.present(alertController, animated: true, completion: nil)
        alertController.view.tintColor = UIColor.gray
        
    }
    
    func showAlert(title: String, message: String) {
        showAlertWithTitle(title, message: message)
    }
}

extension MainViewController: BottomBarTransitionProtocol {
    func openModule(identifier: Int) {
        presenter.openModule(identifier: identifier)
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if KitRealmManager.sharedManager.showCollectionView {
            return KitRealmManager.sharedManager.getRealm().filter("type = %s", KitRealmManager.sharedManager.getType).count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCell", for: indexPath) as! MainKitsCell
        if KitRealmManager.sharedManager.getRealm().filter("type = %s", KitRealmManager.sharedManager.getType).count >= indexPath.row {
            cell.setupCell(kit: KitRealmManager.sharedManager.getRealm().filter("type = %s", KitRealmManager.sharedManager.getType)[indexPath.row])
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.size.width
        return CGSize.init(width: (width/2) - 1, height: (width/2) )
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if KitRealmManager.sharedManager.showCollectionView {
            delegate?.selectedKits(kitId: KitRealmManager.sharedManager.getRealm()[indexPath.row].id, ownerId: KitRealmManager.sharedManager.getRealm()[indexPath.row].owner)
        }
        
    }
    
}

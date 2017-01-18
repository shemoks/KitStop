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

// MARK: - MainViewController

final class MainViewController: UIViewController, FlowController, MainFilterContainerTransferDataProtocol, Alertable {

    // MARK: - VIPER stack
    
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var toolbarContainer: UIView!
    
    var presenter: MainViewOutput!
    fileprivate var refreshControl = UIRefreshControl()
    fileprivate var kits: [Product] = []
    var delegate: MainViewPassDataProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LoadingIndicatorView.hide()
        collectionView.delegate = self
        collectionView.dataSource = self
        addSectionInset()
        addNavigationBarItems()
        addRefreshControl()
        addToolbar()
        presenter.handleKitForSale()
        
        //test hardcode
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "log out", style: .done, target: self, action: #selector(logOut))
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.navigationBar.tintColor = UIColor(red: 255/255, green: 136/255, blue: 48/255, alpha: 1)
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.tintColor = UIColor(red: 255/255, green: 136/255, blue: 48/255, alpha: 1)
    }
    
    func addRefreshControl() {
        refreshControl.bounds = CGRect.init(x: refreshControl.bounds.origin.x, y: 25, width: refreshControl.bounds.size.width, height: refreshControl.bounds.size.height)
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        collectionView.addSubview(refreshControl)
    }
    
    func refresh() {
        print("refresh")
        refreshControl.endRefreshing()
    }
    
    //test hardcode
    func logOut() {
        let realm = try! Realm()
        try! realm.write {
            realm.objects(User.self).filter("online = %s", true).first?.online = false
        }
        KeychainService().clearToken()
        presenter.logoutFromFacebook()
        self.dismiss(animated: true, completion: nil)
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
        layout.sectionInset = UIEdgeInsetsMake((self.navigationController?.navigationBar.frame.size.height)! , 0, (self.navigationController?.toolbar.frame.size.height)!, 0)
        collectionView.collectionViewLayout = layout
    }
    
    func updateData(kits: [Product]) {
        self.kits = kits
        self.collectionView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let container = segue.destinationViewController(ofType: MainFilterContainerViewController.self)
        container?.transferData = self
    }
    
    func kitItems(transferData: [Product]) {
        self.kits = transferData
        collectionView.reloadData()
    }
    
    func passDataToSubmodule() {
        delegate?.passData(selectedItem: 2)
    }
    
    func addToolbar() {
        let toolBar = UIView.loadFromNibNamed(nibNamed: "BottomBar")
  
        toolBar?.frame = CGRect(x: 0, y: 0, width: toolbarContainer.frame.width, height: toolbarContainer.frame.height)
        
        (toolBar as? BottomBarViewController)?.tappedItem = self
        toolbarContainer.addSubview(toolBar!)
        
    }
}

// MARK: - MainViewInput

extension MainViewController: MainViewInput {
    
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
        return kits.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCell", for: indexPath) as! MainKitsCell
        cell.setupCell(row: indexPath.row, kit: kits[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.size.width
        return CGSize.init(width: (width/2) - 1, height: (width/2) )
    }
}

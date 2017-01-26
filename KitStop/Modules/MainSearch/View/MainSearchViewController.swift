//
//  MainSearchViewController.swift
//  KitStop
//
//  Created by Dmitriy Melnichenko on 04/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

import Chamomile

// MARK: - MainSearchViewController

final class MainSearchViewController: UIViewController, FlowController, Alertable {

    // MARK: - VIPER stack

    var presenter: MainSearchViewOutput!
    
    // MARK: - Outlets
    

   
    @IBOutlet weak var search: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!

    

    // MARK: - Life cycle 
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.topItem?.title = ""
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        search.delegate = self
        search.layer.borderWidth = 1
        search.layer.borderColor = UIColor.white.cgColor
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let searchField = search.value(forKey: "searchField") as? UITextField
        searchField?.backgroundColor = UIColor(colorLiteralRed: 232/255, green: 232/255, blue: 234/255, alpha: 1.0)
        
        search.placeholderText = presenter.setTitle()
        
        var searchTextField: UITextField? = search.value(forKey: "searchField") as? UITextField
        searchField?.tintColor = .black
        if searchTextField!.responds(to: #selector(getter: UITextField.attributedPlaceholder)) {
            var color = UIColor.darkText
            let attributeDict = [NSForegroundColorAttributeName: UIColor(colorLiteralRed: 151/255, green: 153/255, blue: 155/255, alpha: 1.0)]
            searchTextField!.attributedPlaceholder = NSAttributedString(string: presenter.setTitle(), attributes: attributeDict)
        }
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Actions 
    
    @IBAction func tapOnCancel(_ sender: Any) {
        presenter.closeModule()
    }

}


// MARK: - MainSearchViewInput

extension MainSearchViewController: MainSearchViewInput {
    func reloadData() {
        collectionView.reloadData()
    }
    
    func showAlert(title: String, message: String) {
        self.showAlertWithTitle(title, message: message)
    }
}

// MARK: - UISearchBarDelegate

extension MainSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(searchBar.text!)
        presenter.handleSearchButtonTap(title: searchBar.text!)
        searchBar.resignFirstResponder()
    }
}


// MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout

extension MainSearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfKits()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCell", for: indexPath) as! MainKitsCell
        cell.setupCell(row: indexPath.row, kit: presenter.kit(for: indexPath))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.size.width
        return CGSize.init(width: (width/2) - 1, height: (width/2) )
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.handleItemSelection(for: indexPath)
    }
}


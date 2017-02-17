//
//  SelectCategoryViewController.swift
//  KitStop
//
//  Created by Sasha Atamanskiy on 03/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

import Chamomile

// MARK: - SelectCategoryViewController

final class SelectCategoryViewController: UIViewController, FlowController, Alertable {

    // MARK: - VIPER stack

    var presenter: SelectCategoryViewOutput!
    fileprivate var category: [CategoryList] = []
    fileprivate var selectedRow: IndexPath?
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        presenter.fetchCategory()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style: .plain, target:nil, action:nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        setupNavigationBar()
        if let row = selectedRow {
            tableView.deselectRow(at: row, animated: false)
        }
    }
    
    func setupNavigationBar() {
        self.navigationItem.title = "Select Category"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back_orange_button"), style: .plain, target: self, action: #selector(back))
    }

    func back() {
        presenter.openMainModule()
    }


}

// MARK: - SelectCategoryViewInput

extension SelectCategoryViewController: SelectCategoryViewInput {
    func updateData(categoryList: [CategoryList]) {
        self.category = categoryList
        tableView.frame = CGRect.init(x: tableView.frame.origin.x, y: tableView.frame.origin.y, width: tableView.frame.size.width, height: tableView.contentSize.height + 44)
        self.tableView.reloadData()
    }
    
    func showAlert(errorMassage: String) {
        showAlertWithTitle("Error", message: errorMassage)
    }
}

extension SelectCategoryViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SelectCategoryCell") as! SelectCategoryCell
        cell.setupCell(category: self.category[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return category.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedRow = indexPath
        presenter.openAddItemModule(categoryID: category[indexPath.row].id)
    }
}

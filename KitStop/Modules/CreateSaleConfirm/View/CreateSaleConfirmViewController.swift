//
//  CreateSaleConfirmViewController.swift
//  KitStop
//
//  Created by Dmitriy Melnichenko on 05/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

import Chamomile

// MARK: - CreateSaleConfirmViewController

final class CreateSaleConfirmViewController: UIViewController, FlowController, Alertable {

    // MARK: - VIPER stack
    
    var presenter: CreateSaleConfirmViewOutput!
    
    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
   
    @IBOutlet weak var userPrice: UILabel!
    @IBOutlet weak var shippingFee: UILabel!
    @IBOutlet weak var transactionFee: UILabel!
    @IBOutlet weak var kitStopFee: UILabel!
    @IBOutlet weak var finalPrice: UILabel!
    
    //MARK: - Life cycle 
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setDetails()
        self.title = "For Sale / Camera"
        tableView.register(UINib(nibName: "SaleInfoCell", bundle: nil), forCellReuseIdentifier: "SaleInfoCell")
        
        tableView.delegate = self
        tableView.dataSource = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(tapOnSave))
        navigationItem.rightBarButtonItem?.tintColor = UIColor().hexStringToUIColor(hex: Color.orangeColor)
    }
    
    // MARK: - Actions
    func tapOnSave() {
        
    }

}

// MARK: - CreateSaleConfirmViewInput

extension CreateSaleConfirmViewController: CreateSaleConfirmViewInput {
    func reloadPricingData() {
        
    }
    
    func reloadData() {
        self.tableView.reloadData()
    }
    
    func showAlert(title: String, message: String) {
        showAlertWithTitle(title, message: message)
    }
    
    func returnToMainModule() {
        for controller in self.navigationController!.viewControllers as Array {
            if controller is MainViewController {
                let _ = self.navigationController?.popToViewController(controller, animated: true)
                break
            }
        }
    }
}

extension CreateSaleConfirmViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height/3.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension CreateSaleConfirmViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SaleInfoCell", for: indexPath) as? SaleInfoCell
        cell?.configure(detail: presenter.detail(for: indexPath))
        return cell!
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
}

extension CreateSaleConfirmViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        navigationItem.rightBarButtonItem?.isEnabled = false
        if textField.isEnabled {
            textField.text = textField.text?.replacingOccurrences(of: "$", with: "")
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
            if textField.text != nil && !(textField.text?.isEmpty)! && textField.text?.rangeOfCharacter(from: CharacterSet.whitespaces) == nil{
                if (textField.text?.formattedDouble(decimalPlaces: 2))! < Double(presenter.priceLimit()) {
                    textField.superview?.backgroundColor = .white
                    presenter.setPrice(value: textField.text!)
                } else {
                    textField.superview?.backgroundColor = UIColor(colorLiteralRed: 245.0/255.0, green: 208.0/255.0, blue: 208.0/255.0, alpha: 1.0)
                    presenter.showAlert()
                }
            }
        navigationItem.rightBarButtonItem?.isEnabled = true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        
        if textField.text?.characters.count == 0 && ((string.range(of: ".") != nil) || string.range(of: ",") != nil) {
            return false
        }
        
        let dotsCount = (textField.text?.components(separatedBy: ".").count)! - 1
        let commaCount = (textField.text?.components(separatedBy: ",").count)! - 1
        
        if (dotsCount > 0 ||  commaCount > 0) && (string == "." || string == ",") {
            return false
        }
        
        let newLength = text.characters.count + string.characters.count - range.length
        
        return newLength <= 10
    }
    
}

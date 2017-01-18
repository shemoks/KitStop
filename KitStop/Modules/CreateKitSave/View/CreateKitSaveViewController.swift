//
//  CreateKitSaveViewController.swift
//  KitStop
//
//  Created by Dmitriy Melnichenko on 13/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

import Chamomile

// MARK: - CreateKitSaveViewController

final class CreateKitSaveViewController: UIViewController, FlowController, Alertable {

    // MARK: - VIPER stack

    var presenter: CreateKitSaveViewOutput!
    
    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    // MARK: - Lifecycle 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Kits / Camera"
        presenter.setDetails()
        presenter.setLimit()
        tableView.register(UINib(nibName: "KitPrivacyCell", bundle: nil), forCellReuseIdentifier: "KitPrivacyCell")
        
        tableView.register(UINib(nibName: "KitInfoCell", bundle: nil), forCellReuseIdentifier: "KitInfoCell")
        tableView.addGestureRecognizer(UIGestureRecognizer(target: self, action: #selector(hideKeyboard)))
        datePicker.maximumDate = Date()
        datePicker.addTarget(self, action: #selector(handleDatePicker), for: UIControlEvents.valueChanged)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(tapOnSave))
        navigationItem.rightBarButtonItem?.tintColor = UIColor(colorLiteralRed: 255/255.0, green: 136/255.0, blue: 48/255.0, alpha: 1.0)
    }
    
    func handleDatePicker(sender: UIDatePicker) {
        presenter.setDate(date: datePicker.date.string(format: "dd/MMM/yyyy"))
    }
    
    func tapOnSave() {
        LoadingIndicatorView.show()
        presenter.handleSaveTap()
    }
    
    func hideKeyboard() {
        self.view.endEditing(true)
    }

}

// MARK: - CreateKitSaveViewInput

extension CreateKitSaveViewController: CreateKitSaveViewInput {
    func reloadData() {
        tableView.reloadData()
    }
    
    func showAlert(title: String, message: String) {
        showAlertWithTitle(title, message: message)
    }
}

extension CreateKitSaveViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height/3.0
    }
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 && indexPath.section == 0 {
            datePicker.isHidden = false
        } else {
            datePicker.isHidden = true
        }
        if indexPath.section == 1 {
            presenter.setPrivacy(isPrivate: !presenter.hasPrivacySet())
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 30))
        if (section == 1) {
            headerView.backgroundColor = UIColor(colorLiteralRed: 240.0/255.0, green: 239.0/255.0, blue: 245.0/255.0, alpha: 1.0)
        }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 1 ? 40.0 : 0.0
    }
    
}

extension CreateKitSaveViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.isEnabled {
            textField.text = textField.text?.replacingOccurrences(of: "$", with: "")
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text != nil && !(textField.text?.isEmpty)! {
            if Int(textField.text!)! < presenter.priceLimit() {
                textField.superview?.backgroundColor = .white
                textField.backgroundColor = .white
                presenter.setPrice(value: textField.text!)
            } else {
                textField.superview?.backgroundColor = UIColor(colorLiteralRed: 245.0/255.0, green: 208.0/255.0, blue: 208.0/255.0, alpha: 1.0)
                textField.backgroundColor = UIColor(colorLiteralRed: 245.0/255.0, green: 208.0/255.0, blue: 208.0/255.0, alpha: 1.0)
            }
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.isEnabled {
            guard let text = textField.text else { return true }
            let newLength = text.characters.count + string.characters.count - range.length
            return newLength <= 9
        } else  {
            return true
        }
    }
    
}

extension CreateKitSaveViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell!
        if indexPath.section == 1 {
            let privateCell = tableView.dequeueReusableCell(withIdentifier: "KitPrivacyCell", for: indexPath) as! KitPrivacyCell
            privateCell.configure(isPrivate: presenter.hasPrivacySet())
            cell = privateCell
        } else {
            let infoCell = tableView.dequeueReusableCell(withIdentifier: "KitInfoCell", for: indexPath) as! KitInfoCell
            infoCell.configure(detail: presenter.detail(for: indexPath))
            if indexPath.row == 1{
                infoCell.value.isEnabled = true
                infoCell.value.keyboardType = UIKeyboardType.numberPad
            }
            infoCell.value.delegate = self
            cell = infoCell
        }
        return cell
    }
    
}

//
//  CreateKitSaveViewController.swift
//  KitStop
//
//  Created by Dmitriy Melnichenko on 13/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

import Chamomile
import UIKit

// MARK: - CreateKitSaveViewController

final class CreateKitSaveViewController: UIViewController, FlowController, Alertable {

    // MARK: - VIPER stack

    var presenter: CreateKitSaveViewOutput!
    
    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    var datePicker: UIDatePicker!
    var dateField: UITextField!
    // MARK: - Lifecycle 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Kits / Camera"
        presenter.setDetails()
        presenter.setLimit()
        tableView.register(UINib(nibName: "KitPrivacyCell", bundle: nil), forCellReuseIdentifier: "KitPrivacyCell")
        
        tableView.register(UINib(nibName: "KitInfoCell", bundle: nil), forCellReuseIdentifier: "KitInfoCell")
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(tapOnSave))
        navigationItem.rightBarButtonItem?.tintColor = UIColor(colorLiteralRed: 255/255.0, green: 136/255.0, blue: 48/255.0, alpha: 1.0)

    }
    
    func tapOnSave() {
        LoadingIndicatorView.show()
        presenter.handleSaveTap()
    }
    
    func pickUpDate(textField: UITextField) {
        
        //DatePicker
        self.datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
        self.datePicker.backgroundColor = UIColor.white
        self.datePicker.datePickerMode = .date
        self.datePicker.maximumDate = Date()
        textField.inputView = self.datePicker
        
        //ToolBar
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 92/255, green: 216/255, blue: 255/255, alpha: 1)
        toolBar.sizeToFit()
        
        //Buttons
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(CreateKitSaveViewController.doneTap))
        doneButton.tintColor = UIColor().hexStringToUIColor(hex: Color.orangeColor)
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(CreateKitSaveViewController.cancelTap))
        cancelButton.tintColor = UIColor().hexStringToUIColor(hex: Color.orangeColor)
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
        
    }
    
    func doneTap() {
        presenter.setDate(date: datePicker.date.string(format: "dd/MMM/yyyy"))
        dateField.resignFirstResponder()
    }
    
    func cancelTap() {
        dateField.resignFirstResponder()
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
    
    func returnToMainModule() {
        for controller in self.navigationController!.viewControllers as Array {
            if controller is MainViewController {
                let _ = self.navigationController?.popToViewController(controller, animated: true)
                break
            }
        }
    }
}

extension CreateKitSaveViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height/3.0
    }
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
        navigationItem.rightBarButtonItem?.isEnabled = false
        if textField.isEnabled {
            textField.text = textField.text?.replacingOccurrences(of: "$", with: "")
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField != dateField {
            if textField.text != nil && !(textField.text?.isEmpty)! && textField.text?.rangeOfCharacter(from: CharacterSet.whitespaces) == nil{
                if (textField.text?.formattedDouble(decimalPlaces: 2))! < Double(presenter.priceLimit()) {
                    textField.superview?.backgroundColor = .white
                    presenter.setPrice(value: textField.text!)
                } else {
                    textField.superview?.backgroundColor = UIColor(colorLiteralRed: 245.0/255.0, green: 208.0/255.0, blue: 208.0/255.0, alpha: 1.0)
                    presenter.showAlert()
                }
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
            
           infoCell.value.clipsToBounds = true
           
            if indexPath.row == 1{
                infoCell.value.isEnabled = true
                infoCell.value.keyboardType = UIKeyboardType.decimalPad
            }
            
            if indexPath.section == 0 && indexPath.row == 0 {
                infoCell.value.isEnabled = true
                self.dateField = infoCell.value
                self.pickUpDate(textField: self.dateField)
            }
        
            infoCell.value.delegate = self
            
            cell = infoCell
        }
        return cell
    }
    
}

//
//  UIViewController+Alertable.swift
//  KitStop
//
//  Created by Dmitriy Melnichenko on 12/21/16.
//  Copyright © 2016 MOZI Development. All rights reserved.
//

import UIKit

protocol Alertable: NSObjectProtocol {
    func showAlertWithTitle(_ title: String?, message: String?, actions: [UIAlertAction])
    func showAlertWithTitle(_ title: String?, message: String?)
}

extension Alertable where Self: UIViewController {
    
    func showAlertWithTitle(_ title: String?, message: String?, actions: [UIAlertAction]) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        actions.forEach{ (action) in
            alertController.addAction(action)
        }
        
        present(alertController, animated: true, completion: nil)
    }
    
    func showAlertWithTitle(_ title: String?, message: String?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default) {_ in
            alertController.dismiss(animated: true, completion: nil)
        }
        
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
}

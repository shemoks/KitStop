//
//  MainFilterContainerViewController.swift
//  KitStop
//
//  Created by Sasha Atamanskiy on 19/12/2016.
//  Copyright © 2016 MoziDev. All rights reserved.
//

import Chamomile

// MARK: - MainFilterContainerViewController

final class MainFilterContainerViewController: UIViewController, FlowController {

    // MARK: - VIPER stack

    @IBOutlet weak var kitSegmentControl: UISegmentedControl!
    var presenter: MainFilterContainerViewOutput!
    
    @IBAction func tapOnFilterButton(_ sender: Any) {
        presenter.openFilterModule()
    }
    
    @IBAction func tapOnSearchButton(_ sender: Any) {
        presenter.openSearchModule()
    }
    
    @IBAction func changeKitsElement(_ sender: Any) {
        
    }
    

}

// MARK: - MainFilterContainerViewInput

extension MainFilterContainerViewController: MainFilterContainerViewInput {

}

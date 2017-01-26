//
//  PortraitOnlyViewController.swift
//  FullScreenPreview
//
//  Created by sasha ataman on 24.01.17.
//  Copyright © 2017 sasha ataman. All rights reserved.
//

import UIKit
import Foundation

class PortraitOnlyViewController: UIViewController {

    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return UIInterfaceOrientation.portrait
    }

}

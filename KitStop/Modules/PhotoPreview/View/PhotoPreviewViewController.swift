//
//  PhotoPreviewViewController.swift
//  KitStop
//
//  Created by Sasha Atamanskiy on 24/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

import Chamomile

// MARK: - PhotoPreviewViewController

final class PhotoPreviewViewController: UIViewController, FlowController {

    // MARK: - VIPER stack

    var presenter: PhotoPreviewViewOutput!

}

// MARK: - PhotoPreviewViewInput

extension PhotoPreviewViewController: PhotoPreviewViewInput {

}

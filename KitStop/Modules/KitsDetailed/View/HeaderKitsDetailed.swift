//
//  HeaderKitsDetailed.swift
//  KitStop
//
//  Created by Mac on 1/18/17.
//  Copyright © 2017 MOZI Development. All rights reserved.
//

import Foundation
import UIKit

class HeaderKitsDetailed: UIView {

    var view: UIView!
    var nibName: String = "HeaderKitsDetailed"
    var xib = UIView()

    @IBOutlet weak var userInfo: UIView!
    

    @IBOutlet weak var imageView: UIImageView!


    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    override func awakeFromNib() {
        super.awakeFromNib()

    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        setup()
    }

    func setup() {
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
        xib = UIView.loadFromNibNamed(nibNamed: "UserInformation")!
        xib.frame = CGRect.init(x: 0, y: 0, width: userInfo.frame.width, height: userInfo.frame.height)
        userInfo.addSubview(xib)

    }

    func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }


    
}

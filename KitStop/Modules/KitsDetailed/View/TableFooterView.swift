//
//  TableFooterView.swift
//  KitStop
//
//  Created by Mac on 1/19/17.
//  Copyright © 2017 MOZI Development. All rights reserved.
//

import Foundation
import UIKit

class TableFooterView: UIView {

    var view: UIView!
    var nibName: String = "View"
    var xib = UIView()


    @IBOutlet weak var dateUpdate: UILabel!
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

    }

    func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
    
    
    
}


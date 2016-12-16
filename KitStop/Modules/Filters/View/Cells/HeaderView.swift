//
//  HeaderView.swift
//  KitStop
//
//  Created by Mac on 12/15/16.
//  Copyright © 2016 MOZI Development. All rights reserved.
//

import UIKit

class HeaderView: UIView {
    var view: UIView!
    var nibName: String = "HeaderView"

    @IBOutlet weak var headLabel: UILabel!

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
        headLabel.textColor = .gray
        addSubview(view)


    }

    func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }



}

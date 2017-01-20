//
//  HeaderForSale.swift
//  KitStop
//
//  Created by Mac on 1/20/17.
//  Copyright © 2017 MOZI Development. All rights reserved.
//

import UIKit

class HeaderForSale: UIView {

    typealias ButtonAction = () -> ()
    var view: UIView!
    var nibName: String = "HeaderForSale"

    @IBOutlet weak var price: UILabel!
    var onTouch: ButtonAction?


    @IBAction func BuyNowTap(_ sender: Any) {
        onTouch?()
    }

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


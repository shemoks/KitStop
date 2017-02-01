//
//  ViewForOwner.swift
//  KitStop
//
//  Created by Mac on 2/1/17.
//  Copyright © 2017 MOZI Development. All rights reserved.
//

import UIKit

class ViewForOwner: UIView {

    var view: UIView!
    var nibName: String = "ViewForOwner"
    var priceValue: Double = 0.00
    var rates: RatesModel?




    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var shipping: UILabel!
    @IBOutlet weak var transaction: UILabel!
    @IBOutlet weak var kitStop: UILabel!
    @IBOutlet weak var make: UILabel!

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
        if rates != nil {
        self.price.text = "$" + String(describing: price)
//        self.shipping.text = "$" + rates.
//        self.transaction.text = "$" + String(describing: transaction)
//        let shippingFee = priceValue * shippingValue/100
//        let transactionFee = priceValue * transaction/100
//        let kitStopFee = price * transaction/100
//        let finalPrice = price - shippingFee - transactionFee - kitStopFee
//        self.make.text = "$" + String(finalPrice)

    }
    }

    func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
    
}


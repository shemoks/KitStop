//
//  ViewForOwner.swift
//  KitStop
//
//  Created by Mac on 2/1/17.
//  Copyright © 2017 MOZI Development. All rights reserved.
//

import UIKit
protocol TransportPost {
    func returnPost (post: Post)
}

class ViewForOwner: UIView {

    var view: UIView!
    var nibName: String = "ViewForOwner"
    var priceValue: Double = 0.00
    var rates: PriceModel?


    @IBOutlet weak var shippingString: UILabel!
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

    }

    func reloadView() {
        self.price.text = rates?.startingPrice
        self.shippingString.text = rates?.weight
        self.shipping.text = rates?.weightRate
        self.transaction.text = rates?.transactionPrice
        self.kitStop.text = rates?.kitStopPrice
        self.make.text = rates?.finalPrice
    }

    func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
    
}


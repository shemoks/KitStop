//
//  Carusel.swift
//  KitStop
//
//  Created by Mac on 1/25/17.
//  Copyright © 2017 MOZI Development. All rights reserved.
//

import Foundation
import UIKit

class CaruselHeader: UIView {
    typealias ButtonAction = () -> ()
    var onTouch: ButtonAction?

    @IBOutlet weak var privateLabel: UILabel!
    @IBAction func likeTap(_ sender: Any) {
        onTouch?()
    }
    var view: UIView!
    var nibName: String = "CaruselHeader"
    var xib = UIView()
    var caruselXib = UIView()

    @IBOutlet weak var like: UIButton!
    @IBOutlet weak var carusel: Carusel!
    @IBOutlet weak var userInfoContainer: UIView!
    var actualView: UIView?
  //  var caruselView: UIView?

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
        xib.frame = CGRect.init(x: 0, y: 0, width: userInfoContainer.frame.width, height: userInfoContainer.frame.height)
        userInfoContainer.addSubview(xib)
        actualView = xib
//        caruselXib = UIView.loadFromNibNamed(nibNamed: "Carusel")!
//        caruselXib.frame = CGRect.init(x: 0, y: 0, width: carusel.frame.width, height: carusel.frame.height)
//        carusel.addSubview(xib)
//        caruselView = caruselXib

    }

    func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }

}

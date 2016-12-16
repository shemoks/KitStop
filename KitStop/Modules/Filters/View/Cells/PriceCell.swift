//
//  PriceCell.swift
//  KitStop
//
//  Created by Mac on 12/15/16.
//  Copyright © 2016 MOZI Development. All rights reserved.
//

import UIKit


class PriceCell: UITableViewCell {

 
    @IBOutlet weak var priceRangeSlider: RangeSlider!
    @IBOutlet weak var maxPraceLabel: UILabel!
    @IBOutlet weak var minPriceLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
       // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func rangeSliderValueChanged(_ rangeSlider: RangeSlider) {
        print("Range slider value changed: (\(rangeSlider.lowerValue) , \(rangeSlider.upperValue))")
    }

}

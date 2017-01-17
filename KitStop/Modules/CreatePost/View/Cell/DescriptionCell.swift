//
//  DescriptionCell.swift
//  KitStop
//
//  Created by Mac on 1/5/17.
//  Copyright © 2017 MOZI Development. All rights reserved.
//

import UIKit

protocol ResizeTextViewDelegate {

    func resizeTextView(textView: UITextView)

}

class DescriptionCell: UITableViewCell, UITextViewDelegate {
    var delegate: ResizeTextViewDelegate?
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var descriptions: UITextView!
    var object: Property?
    func configure(property: Property) {
        self.object = property
        title.text = property.title
        self.descriptions.textColor = UIColor.black
        if self.descriptions.text == "" || self.descriptions.text == property.placeholder {
            self.descriptions.textColor = UIColor(red: (151/255.0), green: (153/255.0), blue: (155/255.0), alpha: 1.0)
            self.descriptions.text = property.placeholder
        }
        //    self.descriptions.text = property.textValue
        descriptions.delegate = self

    }

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if textView.text == nil {
            textView.textColor = UIColor(red: (151/255.0), green: (153/255.0), blue: (155/255.0), alpha: 1.0)
            textView.text = (self.object?.placeholder)!
        }
        let currentCharacterCount = descriptions.text?.characters.count ?? 0
        if (range.length + range.location > currentCharacterCount){
            return false
        }
        let newLength = currentCharacterCount + text.characters.count - range.length
        if let limit = object?.limit {
            return newLength <= limit
        } else {
            return newLength <= 500
        }

    }

    func textViewDidChange(_ textView: UITextView) {
        delegate?.resizeTextView(textView: descriptions)

    }

    func textViewDidEndEditing(_ textView: UITextView) {
        self.object?.textValue = textView.text
    }

    func textViewDidBeginEditing(_ textView: UITextView) {
        if self.descriptions.text == (self.object?.placeholder)! {
            textView.text = nil
        }
        self.descriptions.textColor = UIColor.black
    }
    
}

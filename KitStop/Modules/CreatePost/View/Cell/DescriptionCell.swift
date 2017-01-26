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
    @IBOutlet weak var descriptions: MyTextView!
    var object: Property?
    func configure(property: Property) {
        self.object = property
        title.text = property.title

        descriptions.placeholderLabel.textColor = UIColor(red: (151/255.0), green: (153/255.0), blue: (155/255.0), alpha: 0.5)
        descriptions.placeholderLabel.text = property.placeholder
        descriptions.delegate = self
    }

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        textView.textColor = UIColor.black
        let currentCharacterCount = textView.text?.characters.count ?? 0
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

      func validation(data: String) -> Bool {
        let newData = data.trimmingCharacters(in: .whitespaces)
        if data.characters.count > 0 && newData.characters.count > 0  {
            return true
        }
        return false
    }

}

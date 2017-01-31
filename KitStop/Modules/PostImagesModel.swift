//
//  PostImagesModel.swift
//  KitStop
//
//  Created by Mac on 1/30/17.
//  Copyright © 2017 MOZI Development. All rights reserved.
//
import Foundation
import UIKit



class PostImagesModel {
    enum CellImage {
        case Required, Add, Actual(image: UIImage), Remote(url: URL), Blank
    }

    private let maxLimit = 6

    private var items: [CellImage] = []

    func add(image: UIImage) {
        if items.count < maxLimit {
            items.append(.Actual(image: image))
        }
    }

    func add(url: URL) {
        if items.count < maxLimit {
            items.append(.Remote(url: url))
        }
    }

    func remove(index: Int) {
        guard index < items.count else { return }

        items.remove(at: index)
    }

    var toDisplay: [CellImage] {
        get {
            guard !items.isEmpty else {
                var initial: [CellImage] = [.Required]

                for _ in 1...maxLimit - 1 {
                    initial.append(.Blank)
                }

                return initial
            }

            var toReturn = items

            if items.count < maxLimit {
                toReturn.append(.Add)
            }

            let left = maxLimit - items.count

            if left > 0 {
                for i in 0...left {
                    if i != left && i != 0 {
                        toReturn.append(.Blank)
                    }
                }
            }

            return toReturn
        }
    }
    
    var forGallery: [CellImage] {
        get {
            return items
        }
    }
}

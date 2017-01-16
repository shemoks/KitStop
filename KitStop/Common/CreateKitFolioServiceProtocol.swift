//
//  CreateKitFolioServiceProtocol.swift
//  KitStop
//
//  Created by sasha ataman on 05.01.17.
//  Copyright © 2017 MOZI Development. All rights reserved.
//

import Foundation


protocol CreateKitFolioServiceProtocol {
    func createKitFolioItem(postTitle: String, postDescription: String , mainImageUrl: String, arrayImageUrl: [String],completionBlock: @escaping (Bool, _ error: Int?) -> ())
}

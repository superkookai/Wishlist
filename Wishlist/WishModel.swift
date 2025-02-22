//
//  WishModel.swift
//  Wishlist
//
//  Created by Weerawut Chaiyasomboon on 22/2/2568 BE.
//

import Foundation
import SwiftData

//Model <-> ModelCOntainer <-> ModelContext <-> View

@Model
class Wish {
    var title: String
    
    init(title: String) {
        self.title = title
    }
}

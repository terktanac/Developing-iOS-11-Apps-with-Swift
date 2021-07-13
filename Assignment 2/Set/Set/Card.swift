//
//  Card.swift
//  Set
//
//  Created by Chanchiew, Tana (Agoda) on 8/7/2564 BE.
//

import Foundation
import UIKit

struct Card: Equatable, Hashable {
    
    var isSelected = false
    
    var isShowed = false
    
    var value: CardValue?
    
    private var id: String
    
    init() {
        self.id = UUID().uuidString
    }
    
}
